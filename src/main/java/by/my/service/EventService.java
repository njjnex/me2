package by.my.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import by.my.entity.Event;
import by.my.entity.User;

public interface EventService {

	public void createEvent(Event event, MultipartFile file);
	public List<Event> getEvents();
	public void removeEvent(Event event);
	public Event getEventByID(long eventId);
	public void updateEvent(Event event);
	public void unjoinEvent(long eventId, long userId);
	public List<Event> getUsersEvents(User user);
	void joinEvent(long eventId, long userId);
	public List<Event> search(String name);
	public List<Event> getUserJoinedEvents(User user);
}
