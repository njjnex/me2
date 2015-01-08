package by.my.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import by.my.entity.Event;
import by.my.entity.Message;

@Repository
public class MessageDoaImpl implements MessageDao {
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void save(Message message) {
		sessionFactory.getCurrentSession().save(message);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Message> getEventMessages(Event event) {
		return sessionFactory
				.getCurrentSession()
				.createQuery(
						"FROM Message message WHERE message.event =:event order by date desc, id desc")
				.setParameter("event", event).list();

	}

}
