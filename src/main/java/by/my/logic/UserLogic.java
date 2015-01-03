package by.my.logic;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import by.my.service.UserService;

/**
 * @author njjnex 
 * 	Checks if username is unique by comparing with usernames from
 *  database
 */
@Component
public class UserLogic {

	@Autowired
	UserService userService;

	public boolean isUniqueUser(String username) {
		if (userService.getUser(username) != null)
			return false;
		else
			return true;
	}
}
