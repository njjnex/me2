package by.my.dao;

import java.util.List;

import by.my.entity.Event;
import by.my.entity.Message;

public interface MessageDao {
	public void save(Message message);
	public List<Message> getEventMessages(Event event);
	public Message getMessage(long messageId);
	public void removeMessage(Message message);
}
