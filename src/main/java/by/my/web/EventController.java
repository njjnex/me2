package by.my.web;

import java.io.IOException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import by.my.entity.Event;
import by.my.entity.Message;
import by.my.entity.User;
import by.my.service.EventService;
import by.my.service.MessageService;
import by.my.service.UserService;

@Controller
public class EventController {
	List<Event> eventList = new ArrayList<Event>();
	boolean imageLoaded;
	@Autowired
	EventService eventService;
	@Autowired
	UserService userService;
	@Autowired
	MessageService messageService;

	private static final Logger logger = LogManager
			.getLogger(EventController.class);

	@RequestMapping(value = "newEvent.html", method = RequestMethod.GET)
	public String viewRegistration(Map<String, Object> model,
			HttpServletRequest request) {
		Event event = new Event();
		model.put("event", event);
		logger.info(request.getRequestURL() + " User:"
				+ request.getUserPrincipal().getName()
				+ "going to create new event.");
		return "event/newEvent";
	}

	@RequestMapping(value = "newEvent.html", method = RequestMethod.POST)
	public String processRegistration(@ModelAttribute("event") Event event,
			Principal principal, Map<String, Object> model,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpSession session) throws HibernateException, IOException {
		// Converting date format
		try {
			String dateStarts = event.getDateStarts();
			DateFormat outputFormat = new SimpleDateFormat(
					"dd-MM-yyyy' в 'HH:mm");
			DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
			Date date = inputFormat.parse(dateStarts);
			String outputDate = outputFormat.format(date);
			event.setDateStarts(outputDate);
		} catch (Exception e) {
			e.printStackTrace();
		}
		String createdUserName = principal.getName();
		User createdUser = userService.getUser(createdUserName);
		event.setCreatedBy(createdUser);
		// No need to load image from db if user didn't upload it
		if (file.isEmpty()) {
			event.setImageLoded(true);
			imageLoaded = true;
		}
		eventService.createEvent(event, file);
		session.setAttribute("imagesLoded", imageLoaded);
		logger.info("New event:" + event.getEventName() + " was created by: "
				+ event.getCreatedBy().getUsername());
		return "redirect:/main.html";
	}

	@RequestMapping(value = "{eventId}/joinEvent.html")
	public String joinEvent(@PathVariable long eventId, Model model,
			Principal principal, HttpServletRequest request) {
		String joinedUserName = principal.getName();
		User joinedUser = userService.getUser(joinedUserName);
		Boolean alreadyJoined = false;
		// Checking if user already joined this event
		for (Event event : joinedUser.getUserJoinedEvents()) {
			if (event.getId() == eventId)
				alreadyJoined = true;
		}
		if (!alreadyJoined) {
			long userId = joinedUser.getId();
			eventService.joinEvent(eventId, userId);
			logger.info(request.getRequestURL() + " Joined event ID: "
					+ eventId + " by USER: " + joinedUserName);
		}
		return "event/eventDetails";
	}

	@RequestMapping(value = "{eventId}/deleteEvent.html")
	public String delete(@PathVariable long eventId, Model model,
			Principal principal) {
		Event event = eventService.getEventByID(eventId);
		//Only user that created event can delete it or Admin
		if ((principal.getName().equals(event.getCreatedBy().getUsername()))
				|| principal.getName().equals("Admin")) {
			eventService.removeEvent(event);
			logger.info("Event delited: " + event.getEventName() + " by user: "
					+ principal.getName());
		}
		return "redirect:/main.html";
	}

	@RequestMapping(value = "{eventId}/unjoinEvent.html")
	public String unjoin(@PathVariable long eventId, Model model,
			Principal principal) {
		Event event = eventService.getEventByID(eventId);
		String joinedUserName = principal.getName();
		User joinedUser = userService.getUser(joinedUserName);
		long userId = joinedUser.getId();
		eventService.unjoinEvent(eventId, userId);
		model.addAttribute("event", event);
		logger.info("Unjoined event ID: " + eventId + " by USER: "
				+ joinedUserName);
		return "event/eventDetails";
	}

	@RequestMapping(value = "events/{eventId}")
	public String eventDetails(@PathVariable("eventId") long eventId,
			Model model) {
		Event event = eventService.getEventByID(eventId);
		List<Message> messageList = messageService.getEventMessages(event);
		model.addAttribute("event", event);
		model.addAttribute("messages", messageList);
		logger.info("Event details: " + event.getEventName());
		return "event/eventDetails";
	}

	@RequestMapping(value = "events/{eventId}/postMessage.html")
	public String postMessage(@PathVariable("eventId") long eventId,
			@RequestParam(value = "text", required = false) String text,
			Model model, Principal principal) {
		Event event = eventService.getEventByID(eventId);
		//User post message
		if (!(text == null || text.equals(""))) {
			User user = userService.getUser(principal.getName());
			String date = new SimpleDateFormat("dd-MM-yyyy' в 'HH:mm")
					.format(new Date());
			Message message = new Message();
			message.setAuthor(user);
			message.setDate(date);
			message.setText(text);
			message.setEvent(event);
			messageService.save(message);
			logger.info("Post message: " + text + "; to event "
					+ event.getEventName() + " ; by user " + user.getUsername());
		}
		List<Message> messageList = messageService.getEventMessages(event);
		model.addAttribute("event", event);
		model.addAttribute("messages", messageList);

		return "event/eventDetails";
	}
}
