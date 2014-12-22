package by.my.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import by.my.entity.Event;
import by.my.logic.ImageFromDBLoader;
import by.my.service.EventService;

@Controller
public class MainController {

	List<Event> eventList = new ArrayList<Event>();

	@Autowired
	EventService eventService;
	
	@RequestMapping(value = "/main.html")
	public String mainView(
			@RequestParam(value = "searchEventName", required = false) String searchEventName,
			Model model, HttpServletRequest request) {

		/* Checks if request comes from search form.*/
		if (searchEventName != null) {
			eventList = eventService.search(searchEventName);
		} else {
			eventList = eventService.getEvents();
		}

		Iterator<Event> it = eventList.iterator();
		while (it.hasNext()) {
			Event event = it.next();
			/*
			 * Checks if event is active by comparing today date with event
			 * dateStarts
			 */
			String dateS = event.getDateStarts();
			try {
				Date date = new SimpleDateFormat("dd-MM-yyyy' в 'HH:mm").parse(dateS);
				Date today = new Date();

				if (today.before(date)) {
					event.setActive(true);
				} else {
					event.setActive(false);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			/*
			 * Check's if event image was loaded from db to server if not loads
			 * image to the server
			 */
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
}
