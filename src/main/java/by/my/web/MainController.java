package by.my.web;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import by.my.entity.Event;
import by.my.entity.User;
import by.my.logic.EventState;
import by.my.logic.ImageFromDBLoader;
import by.my.service.EventService;
import by.my.service.UserService;

@Controller
public class MainController {

	List<Event> eventList = new ArrayList<Event>();

	@Autowired
	EventService eventService;
	@Autowired
	UserService userService;
	@Autowired
	EventState eventState;

	@RequestMapping(value = "/main.html")
	public String mainView(
			@RequestParam(value = "searchEventName", required = false) String searchEventName,
			Model model) {

		/* Checks if request comes from search form. */
		if (searchEventName != null) {
			eventList = eventService.search(searchEventName);
		} else {
			eventList = eventState.upToDateEvents(eventService.getEvents());
		}
		/*
		 * Check's if event image was loaded from db to server if not loads
		 * image to the server
		 */
		for (Event event : eventList) {
			if (!event.isImageLoded()) {
				ImageFromDBLoader imageLoader = new ImageFromDBLoader();
				imageLoader.loadEventImage(event);
				event.setImageLoded(true);
				eventService.updateEvent(event);
			}
		}
		model.addAttribute("events", eventList);
		return "main";
	}

	@RequestMapping(value = "active.html")
	public String active(
			@RequestParam(value = "searchEventName", required = false) String searchEventName,
			Model model) {

		if (searchEventName != null) {
			eventList = eventService.search(searchEventName);
		} else {
			eventList = eventService.getEvents();
			eventList = eventState.isActive(eventList);
		}
		model.addAttribute("events", eventList);
		return "main";

	}

	@RequestMapping(value = "unactive.html")
	public String unactive(
			@RequestParam(value = "searchEventName", required = false) String searchEventName,
			Model model) {

		if (searchEventName != null) {
			eventList = eventService.search(searchEventName);
		} else {
			eventList = eventService.getEvents();
			eventList = eventState.isUnactive(eventList);
		}
		model.addAttribute("events", eventList);
		return "main";

	}

	@RequestMapping(value = "myEvents.html")
	public String myEvents(
			@RequestParam(value = "searchEventName", required = false) String searchEventName,
			Model model, Principal principal) {
		if (searchEventName != null) {
			eventList = eventService.search(searchEventName);
		} else {
			eventList = eventService.getEvents();
			String username = principal.getName();
			User user = userService.getUser(username);
			eventList = eventService.getUsersEvents(user);
		}
		model.addAttribute("events", eventList);
		return "main";
	}
	@RequestMapping(value = "{userId}/joinedEvent.html")
	public String userJoinedEvent(@PathVariable("userId") long userId, Model model){
		User user = userService.getUserById(userId);
		eventList = eventService.getUserJoinedEvents(user);
		
		model.addAttribute("events", eventList);
		return "main";
	}
	@RequestMapping(value = "{userId}/createdEvent.html")
	public String userCreatedEvent(@PathVariable("userId") long userId, Model model){
		User user = userService.getUserById(userId);
		eventList = eventService.getUsersEvents(user);
		
		model.addAttribute("events", eventList);
		return "main";
	}
}
