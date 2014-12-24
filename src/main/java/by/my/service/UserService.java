package by.my.service;

import java.util.List;

import by.my.entity.User;

public interface UserService {

	public User getUserById(long id);
	public User getUser(String username);
	public void removeUser(User user);
	public void createUser(User user);
	public List<User> getAllUsers();
	public void updateUser(User user);
}
