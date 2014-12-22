package by.my.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import by.my.entity.User;

@Repository
public class UserDaoImpl implements UserDao {
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void removeUser(User user) {
		long userId = user.getId();
		String query = "delete from myproject.members_joined_event WHERE USER_ID = :user_id";
		Query q = sessionFactory.getCurrentSession().createSQLQuery(query);
		q.setLong("user_id", userId);
		q.executeUpdate();

		sessionFactory.getCurrentSession().delete(user);
	}

	@Override
	public void createUser(User user) {
		sessionFactory.getCurrentSession().save(user);

	}

	@Override
	public User getUserById(long id) {
		return (User) sessionFactory.getCurrentSession().get(User.class, id);
	}

	@Override
	public User getUser(String username) {
		System.out.println("users" + username);

		User user = (User) sessionFactory
				.getCurrentSession()
				.createQuery(
						"select u from User u where u.username = :username")
				.setParameter("username", username).uniqueResult();

		return user;

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> getAllUsers() {
		return sessionFactory.getCurrentSession().createQuery("FROM User user")
				.list();
	}
}
