package by.my.dao;

import java.util.List;

import by.my.entity.User;

public interface UserDao {

	public User getUserById(long id);
	public User getUser(String username);
	public void removeUser(User user);
	public void createUser(User user);
	public List<User> getAllUsers();
}
