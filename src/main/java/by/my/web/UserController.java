package by.my.web;

import java.io.IOException;
import java.security.Principal;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialBlob;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import by.my.entity.Event;
import by.my.entity.User;
import by.my.logic.FileLoader;
import by.my.logic.ImageFromDBLoader;
import by.my.service.UserService;

@Controller
public class UserController {

	List<User> users = new ArrayList<User>();
	boolean avatarLoaded;
	@Autowired
	UserService userService;

	@RequestMapping(value = "/newUser.html", method = RequestMethod.GET)
	public String viewRegistration(Map<String, Object> model) {
		User userForm = new User();
		userForm.setAge(null);
		userForm.setAvatar(null);
		userForm.setGender(null);
		userForm.setPhone(null);

		model.put("userForm", userForm);
		return "user/newUser";
	}

	@RequestMapping(value = "/newUser.html", method = RequestMethod.POST)
	public String processRegistration(@ModelAttribute("userForm") User user,
			BindingResult bindingResult, Map<String, Object> model,
			@RequestParam("confirmPassword") String passwordRep,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam("terms") Boolean terms) {

		// Converting Spring MultipartFile to Blob
		Blob blob = null;
		try {
			byte[] bytes = file.getBytes();
			blob = new SerialBlob(bytes);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// No need to load user avatar from db if user didn't upload it
		if (file.isEmpty()) {
			user.setAvatarLoded(true);
			avatarLoaded = true;
		}

		if (userService.getUser(user.getUsername()) != null) {
			ObjectError error = new ObjectError("nonUniqueUser",
					"Пользователь с таким именем уже существует.");
			bindingResult.addError(error);
		}
		if (bindingResult.hasErrors()) {
			return "user/newUser";
		} else {
			user.setUserRole("ROLE_USER");
			user.setEnabled(true);
			user.setAvatar(blob);
			userService.createUser(user);

			if (!user.isAvatarLoded()) {
				ImageFromDBLoader imageLoader = new ImageFromDBLoader();
				imageLoader.loadUserAvatar(user);
				user.setAvatarLoded(true);
				userService.updateUser(user);
			}
			return "redirect:/success.html";
		}
	}

	@RequestMapping(value = "/updateUser.html", method = RequestMethod.POST)
	public String updateUser(@RequestParam("email") String email,
			@RequestParam("password") String password,
			@RequestParam("phone") String phone,
			@RequestParam(value = "file", required = false) MultipartFile file,
			Principal principal, Model model) {

		User user = userService.getUser(principal.getName());
		Blob blob = null;

		if ((user.getPassword().equals(password))) {
			// if user avatar changed
			if (!file.isEmpty()) {
				try {
					user.setAvatarLoded(false);
					avatarLoaded = false;
					byte[] bytes = file.getBytes();
					blob = new SerialBlob(bytes);
					user.setAvatar(blob);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			if (!user.isAvatarLoded()) {
				ImageFromDBLoader imageLoader = new ImageFromDBLoader();
				imageLoader.loadUserAvatar(user);
				user.setAvatarLoded(true);
			}
			// if email changed
			if (!email.isEmpty())
				user.setEmail(email);
			// if phone changed
			if (!phone.isEmpty())
				user.setPhone(phone);

			userService.updateUser(user);
			return "redirect:/myDetails.html";
		} else {
			model.addAttribute("error", "Неверный пароль");
			return "forward:/myDetails.html";
		}
	}

	@RequestMapping(value = "/admin.html")
	public String admin(Model model) {
		users = userService.getAllUsers();

		model.addAttribute("users", users);
		return "user/admin";

	}

	@RequestMapping(value = "{userId}/deleteUser.html")
	public String deleteUser(@PathVariable("userId") long id, Model model) {
		User user = userService.getUserById(id);
		userService.removeUser(user);
		return "redirect:/admin.html";
	}

	@RequestMapping(value = "{id}/userDetails.html")
	public String userDetails(@PathVariable("id") long id, Model model) {
		User user = userService.getUserById(id);
		model.addAttribute("user", user);
		return "user/userDetails";
	}

	@RequestMapping(value = "/myDetails.html")
	public String myDetails(Model model) {

		String aUser = SecurityContextHolder.getContext().getAuthentication()
				.getName();
		User user = userService.getUser(aUser);
		int joined = user.getUserJoinedEvents().size();
		int created = user.getUserCreatedEvents().size();
		int activeJoined = 0;
			for(Event event: user.getUserJoinedEvents()){
				if (event.isActive()) activeJoined++;
			}
		if (!user.isAvatarLoded()) {
			ImageFromDBLoader imageLoader = new ImageFromDBLoader();
			imageLoader.loadUserAvatar(user);
			user.setAvatarLoded(true);
			userService.updateUser(user);
		}
		
		model.addAttribute("joined",joined);
		model.addAttribute("created",created);
		model.addAttribute("activeJoined",activeJoined);
		model.addAttribute("user", user);
		return "user/myDetails";
	}

	@RequestMapping(value = "{username}/downloadDetails.html")
	public void getFile(@PathVariable("username") String username,
			HttpServletResponse response) throws IOException {
		User user = userService.getUser(username);

		FileLoader fl = new FileLoader();
		String myString = fl.userString(user);
		response.setContentType("text/plain");
		response.setHeader("Content-Disposition",
				"attachment;filename=" + user.getUsername() + ".txt");
		ServletOutputStream out = response.getOutputStream();
		out.write(myString.getBytes("UTF-8"));
		out.flush();
		out.close();
	}

	@RequestMapping(value = "terms.html", method = RequestMethod.GET)
	public String terms() {
		return "templates/terms";
	}

	@RequestMapping(value = "success.html", method = RequestMethod.GET)
	public String registrationSuccess() {
		return "user/registrationSuccess";
	}
}