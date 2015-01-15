package by.my.web;

import java.security.Principal;
import java.sql.Blob;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.sql.rowset.serial.SerialBlob;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
import by.my.logic.ImageFromDBLoader;
import by.my.service.UserService;

@Controller
public class UserController {

	List<User> users = new ArrayList<User>();
	boolean avatarLoaded;
	private static final Logger logger = LogManager
			.getLogger(UserController.class);

	@Autowired
	UserService userService;

	@RequestMapping(value = "/newUser.html", method = RequestMethod.GET)
	public String viewRegistration(Map<String, Object> model,
			HttpServletRequest request) {
		User userForm = new User();
		userForm.setAge(null);
		userForm.setAvatar(null);
		userForm.setGender(null);
		userForm.setPhone(null);

		model.put("userForm", userForm);
		logger.info(request.getHeader("Referer") + " --> "
				+ request.getRequestURL() + " Going to register:"
				+ request.getRemoteAddr());
		return "user/newUser";
	}

	@RequestMapping(value = "/newUser.html", method = RequestMethod.POST)
	public String processRegistration(@ModelAttribute("userForm") User user,
			BindingResult bindingResult, Map<String, Object> model,
			@RequestParam("confirmPassword") String passwordRep,
			@RequestParam(value = "file", required = false) MultipartFile file,
			@RequestParam("terms") Boolean terms) {

		Blob blob = null;
			
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

			// Converting Spring MultipartFile to Blob
			// No need to load user avatar from db if user didn't upload it
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
			
			userService.createUser(user);
			logger.info("Registred user: " + user.getUsername()
					+ " is avatar loaded :" + user.isAvatarLoded());
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
			logger.info("Updated user: " + user.getUsername()
					+ " is avatar loaded :" + user.isAvatarLoded());
			return "forward:/myDetails.html";
		}
	}

	@RequestMapping(value = "/admin.html")
	public String admin(Model model, HttpServletRequest request) {
		users = userService.getAllUsers();

		model.addAttribute("users", users);
		logger.warn(request.getHeader("Referer") + " --> "
				+ request.getRequestURL() + "Admin is on this page from: "
				+ request.getRemoteAddr());
		return "user/admin";

	}

	@RequestMapping(value = "{userId}/deleteUser.html")
	public String deleteUser(@PathVariable("userId") long id,
			Principal principal, Model model) {
		if (principal.getName().equals("Admin")) {
			User user = userService.getUserById(id);
			userService.removeUser(user);
			logger.info("Delete user: " + user.getUsername() + " by: "
					+ principal.getName());
			return "redirect:/admin.html";
		} else {
			return "main";
		}
	}

	@RequestMapping(value = "{id}/userDetails.html")
	public String userDetails(@PathVariable("id") long id, Model model) {
		User user = userService.getUserById(id);
		int joined = user.getUserJoinedEvents().size();
		int created = user.getUserCreatedEvents().size();

		model.addAttribute("joinedU", joined);
		model.addAttribute("createdU", created);
		model.addAttribute("user", user);
		return "user/userDetails";
	}

	@RequestMapping(value = "/myDetails.html")
	public String myDetails(Model model) {

		String aUser = SecurityContextHolder.getContext().getAuthentication()
				.getName();
		User user = userService.getUser(aUser);
		if (!user.isAvatarLoded()) {
			ImageFromDBLoader imageLoader = new ImageFromDBLoader();
			imageLoader.loadUserAvatar(user);
			user.setAvatarLoded(true);
			userService.updateUser(user);
		}
		int joined = user.getUserJoinedEvents().size();
		int created = user.getUserCreatedEvents().size();
		int activeJoined = 0;
		for (Event event : user.getUserJoinedEvents()) {
			if (event.isActive())
				activeJoined++;
		}
		model.addAttribute("joined", joined);
		model.addAttribute("created", created);
		model.addAttribute("activeJoined", activeJoined);
		model.addAttribute("user", user);
		logger.info("My details viewd by: " + aUser);
		return "user/myDetails";
	}

	@RequestMapping(value = "terms.html", method = RequestMethod.GET)
	public String terms() {
		logger.info("Terms page viewing");
		return "templates/terms";
	}

	@RequestMapping(value = "success.html", method = RequestMethod.GET)
	public String registrationSuccess() {
		logger.info("User registration success");
		return "user/registrationSuccess";
	}
}