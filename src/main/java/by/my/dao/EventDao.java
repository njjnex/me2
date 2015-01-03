package by.my.dao;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import by.my.entity.Event;
import by.my.entity.User;

/**
 * @author njjnex
 *	Base interface for CRUD operations with Event entity
 */
public interface EventDao {
	public void createEvent(Event event, MultipartFile file);
	public List<Event> getEvents();
	public void removeEvent(Event event);
	public Event getEventByID(long eventId);
	public void updateEvent(Event event);
	// called when already joined user wants to unjoin event
	public void unjoinEvent(long eventId, long userId);
	// show all events that user created
	public List<Event> getUsersEvents(User user);
	//join user to event
	void joinEvent(long eventId, long userId);
	public List<Event> search(String name);
	public List<Event> getUserJoinedEvents(User user);
}
