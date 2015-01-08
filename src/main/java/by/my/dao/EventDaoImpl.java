package by.my.dao;

import java.io.IOException;
import java.sql.Blob;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import by.my.entity.Event;
import by.my.entity.User;

@Repository
public class EventDaoImpl implements EventDao {

	@Autowired
	SessionFactory sessionFactory;

	@Override
	public void createEvent(Event event, MultipartFile file) {
		Session session = sessionFactory.getCurrentSession();
		if (file != null) {
			Blob blob;
			try {
				blob = Hibernate.getLobCreator(session).createBlob(
						file.getBytes());
				event.setImage(blob);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		session.save(event);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Event> getEvents() {
		return sessionFactory.getCurrentSession()
				.createQuery("FROM Event event order by active desc, id desc")
				.list(); // sorting shows active events first
	}

	@Override
	public void removeEvent(Event event) {
		//Flash all event messages
		String query = "delete from myproject.message where EVENT_ID = :event_id";
		Query q = sessionFactory.getCurrentSession().createSQLQuery(query);
		q.setLong("event_id", event.getId());
		q.executeUpdate();
		//Delete Event
		sessionFactory.getCurrentSession().delete(event);
	}

	@Override
	public Event getEventByID(long eventId) {
		return (Event) sessionFactory.getCurrentSession().get(Event.class,
				eventId);
	}

	@Override
	public void updateEvent(Event event) {
		sessionFactory.getCurrentSession().merge(event);
	}

	@Override
	public void joinEvent(long eventId, long userId) {
		String query = "insert into myproject.members_joined_event (JOINED_EVENT_ID,USER_ID) VALUES (:event_id, :user_id)";
		Query q = sessionFactory.getCurrentSession().createSQLQuery(query);
		q.setLong("event_id", eventId);
		q.setLong("user_id", userId);
		q.executeUpdate();
	}

	@Override
	public void unjoinEvent(long eventId, long userId) {
		String query = "delete from myproject.members_joined_event where JOINED_EVENT_ID  = :event_id and USER_ID = :user_id";
		Query q = sessionFactory.getCurrentSession().createSQLQuery(query);
		q.setLong("event_id", eventId);
		q.setLong("user_id", userId);
		q.executeUpdate();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Event> getUsersEvents(User user) {
		return sessionFactory.getCurrentSession()
				.createQuery("FROM Event event WHERE event.createdBy = :user")
				.setParameter("user", user).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Event> search(String name) {
		return sessionFactory.getCurrentSession()
				.createQuery("FROM Event event WHERE event.eventName = :name")
				.setParameter("name", name).list();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Event> getUserJoinedEvents(User user) {
		return sessionFactory
				.getCurrentSession()
				.createQuery(
						"FROM Event event WHERE :user in elements(event.eventMembersJoined)")
				.setParameter("user", user).list();
	}
}
