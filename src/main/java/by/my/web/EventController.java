package by.my.web;

import java.io.IOException;
import java.security.Principal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import by.my.entity.User;
import by.my.service.EventService;
import by.my.service.UserService;

@Controller
public class EventController {
	List<Event> eventList = new ArrayList<Event>();
	boolean imageLoaded;
	@Autowired
	EventService eventService;
	@Autowired
	UserService userService;

	@RequestMapping(value = "newEvent.html", method = RequestMethod.GET)
	public String viewRegistration(Map<String, Object> model) {
		Event event = new Event();
		model.put("event", event);

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
			DateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy' в 'HH:mm");
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
						
		//No need to load image from db if user didn't upload it
		if(file.isEmpty()){
			event.setImageLoded(true);
			imageLoaded = true;
		}
		
		eventService.createEvent(event, file);
		session.setAttribute("imagesLoded", imageLoaded);
		

		return "redirect:/main.html";
	}

	@RequestMapping(value = "{eventId}/joinEvent.html")
	public String joinEvent(@PathVariable long eventId, Model model,
			Principal principal) {
		String joinedUserName = principal.getName();
		User joinedUser = userService.getUser(joinedUserName);
		long userId = joinedUser.getId();

		eventService.joinEvent(eventId, userId);

		return "redirect:/main.html";
	}

	@RequestMapping(value = "{eventId}/deleteEvent.html")
	public String delete(@PathVariable long eventId, Model model) {
		Event event = eventService.getEventByID(eventId);
		eventService.removeEvent(event);

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
		return "redirect:/main.html";
	}

	@RequestMapping(value = "events/{eventId}")
	public String eventDetails(@PathVariable("eventId") long eventId,
			Model model) {
		Event event = eventService.getEventByID(eventId);
		model.addAttribute("event", event);
		return "event/eventDetails";
	}
}
