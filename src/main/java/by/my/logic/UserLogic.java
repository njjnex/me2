package by.my.logic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import by.my.service.UserService;

@Component
public class UserLogic {
	
	@Autowired
	UserService userService;
	
	public boolean isUniqueUser(String username){
		System.out.println(userService);
		if (userService.getUser(username) != null)
			return false;
		else 
			return true;	
	}
}