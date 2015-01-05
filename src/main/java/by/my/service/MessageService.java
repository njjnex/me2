package by.my.service;

import java.util.List;

import by.my.entity.Message;
import by.my.entity.Event;

public interface MessageService {
	public void save(Message message);
	public List<Message> getEventMessages(Event event);
}
