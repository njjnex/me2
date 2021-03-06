package by.my.web;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
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
	
	private static final Logger logger = LogManager.getLogger(MainController.class);
	List<Event> eventList = new ArrayList<Event>();
	
	@Autowired
	EventService eventService;
	@Autowired
	UserService userService;
	@Autowired
	EventState eventState;

	@RequestMapping(value = {"", "/","/main.html"})
	public String mainView(
			@RequestParam(value = "searchEventName", required = false) String searchEventName, HttpServletRequest request,
			Model model) {
		
		/* Checks if request comes from search form. */
		if (searchEventName != null) {
			eventList = eventService.search(searchEventName);
			logger.info("User search " + searchEventName + " and as result get " + eventList.size() + " events.");
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
		logger.info(request.getHeader("Referer") + " --> " + request.getRequestURL() + "visited by: " + request.getRemoteAddr() + " principal: " + request.getUserPrincipal() + " refer: " + request.getHeader("Referer"));
		logger.info("Got:  " + eventList.size() + " events.");
		logger.info("Got:  " + request.getLocalAddr() + " events." + request.getQueryString() + request.getRequestURL());
		
		model.addAttribute("events", eventList);
		return "main";
	}

	@RequestMapping(value = "active.html")
	public String active(
			@RequestParam(value = "searchEventName", required = false) String searchEventName,
			Model model, HttpServletRequest request) {
		if (searchEventName != null) {
			eventList = eventService.search(searchEventName);
		} else {
			eventList = eventState.isActive(eventService.getEvents());
		}
		logger.info(request.getHeader("Referer") + " --> " + request.getRequestURL() + "visited by: " + request.getRemoteAddr() + " " + request.getUserPrincipal());
		model.addAttribute("events", eventList);
		return "main";
	}

	@RequestMapping(value = "unactive.html")
	public String unactive(
			@RequestParam(value = "searchEventName", required = false) String searchEventName,
			Model model, HttpServletRequest request) {
		if (searchEventName != null) {
			eventList = eventService.search(searchEventName);
		} else {
			eventList = eventState.isUnactive(eventService.getEvents());
		}
		logger.info(request.getHeader("Referer") + " --> " + request.getRequestURL() + "visited by: " + request.getRemoteAddr() + " : " + request.getUserPrincipal());
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
	public String userJoinedEvent(@PathVariable("userId") long userId, Model model, HttpServletRequest request){
		User user = userService.getUserById(userId);
		eventList = eventService.getUserJoinedEvents(user);

		logger.info(request.getHeader("Referer") + " --> " + request.getRequestURL() +" user: " + request.getUserPrincipal().getName() + " checked " + user.getUsername() + " joined events.");
		model.addAttribute("events", eventList);
		return "main";
	}
	@RequestMapping(value = "{userId}/createdEvent.html")
	public String userCreatedEvent(@PathVariable("userId") long userId, Model model, HttpServletRequest request){
		User user = userService.getUserById(userId);
		eventList = eventService.getUsersEvents(user);

		logger.info(request.getHeader("Referer") + " --> " + request.getRequestURL() +" user: " + request.getUserPrincipal().getName() + " checked " + user.getUsername() + " created events.");
		model.addAttribute("events", eventList);
		return "main";
	}
}
