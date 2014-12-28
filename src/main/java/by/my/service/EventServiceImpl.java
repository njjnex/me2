package by.my.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import by.my.dao.EventDao;
import by.my.entity.Event;
import by.my.entity.User;

@Service
public class EventServiceImpl implements EventService {

	@Autowired
	EventDao eventDao;
	
	@Override
	@Transactional
	public void createEvent(Event event, MultipartFile file) {
		eventDao.createEvent(event,file);
	}

	@Override
	@Transactional
	public List<Event> getEvents() {
		return eventDao.getEvents();
	}

	@Override
	@Transactional
	public void removeEvent(Event event) {
		eventDao.removeEvent(event);

	}

	@Override
	@Transactional
	public Event getEventByID(long eventId) {
		return eventDao.getEventByID(eventId);
	}

	@Override
	@Transactional
	public void updateEvent(Event event) {
		eventDao.updateEvent(event);
		
	}
	@Override
	@Transactional
	public void unjoinEvent(long eventId, long userId){
		eventDao.unjoinEvent(eventId, userId);
		
	}

	@Override
	@Transactional
	public List<Event> getUsersEvents(User user) {
		return eventDao.getUsersEvents(user);
	}

	@Override
	@Transactional
	public void joinEvent(long eventId, long userId) {
		eventDao.joinEvent(eventId, userId);
		
	}

	@Override
	@Transactional
	public List<Event> search(String name) {
		return eventDao.search(name);
	}
	@Override
	@Transactional
	public List<Event> getUserJoinedEvents(User user) {
		return eventDao.getUserJoinedEvents(user);
	}
}
