package by.my.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LoginController {
	
	@RequestMapping(value="/user-login.html", method=RequestMethod.GET)
	public String userLoginForm(Model model){
		return "/login/loginForm";
	}
	
	@RequestMapping(value="/error-login.html", method=RequestMethod.GET)
	public String errorLoginForm(Model model){
		
		return "/login/loginForm";
	}
	
}
