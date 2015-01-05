package by.my.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import by.my.dao.MessageDao;
import by.my.entity.Event;
import by.my.entity.Message;

@Service
public class MessageServiceImpl implements MessageService {
	@Autowired
	MessageDao messageDao;

	@Override
	@Transactional
	public void save(Message message) {
		messageDao.save(message);
	}

	@Override
	@Transactional
	public List<Message> getEventMessages(Event event) {
		return messageDao.getEventMessages(event);
	}
}
