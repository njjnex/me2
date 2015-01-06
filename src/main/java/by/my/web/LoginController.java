package by.my.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	
	private static final Logger logger = LogManager.getLogger(LoginController.class);
	
	@RequestMapping(value="/user-login.html", method=RequestMethod.GET)
	public String userLoginForm(Model model){
		return "/login/loginForm";
	}
	
	@RequestMapping(value="/error-login.html", method=RequestMethod.GET)
	public String errorLoginForm(Model model, HttpServletRequest request){
		model.addAttribute("error", "Неверный логин или пароль!");
		logger.info("User authentification fails " + request.getRemoteAddr() + request.getParameter("j_username"));
		return "forward:/user-login.html";
	}
}
