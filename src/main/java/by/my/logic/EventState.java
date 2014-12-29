package by.my.logic;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import by.my.entity.Event;

public class EventState {
	
	
	public List<Event> isActive(List<Event> eventList) {
		
		for (Iterator<Event> iterator = eventList.iterator(); iterator
				.hasNext();) {
			Event event = iterator.next();
			if (!event.isActive())
				iterator.remove();
		}

		return eventList;
	}

	public List<Event> isUnactive(List<Event> eventList) {

		for (Iterator<Event> iterator = eventList.iterator(); iterator
				.hasNext();) {
			Event event = iterator.next();
			if (event.isActive())
				iterator.remove();
		}
		return eventList;
	}
	/*
	 * Checks if event is active by comparing today date with event
	 * dateStarts
	 */
	public List<Event> upToDateEvents(List<Event> eventList) {

		for (Event event : eventList) {
			String dateS = event.getDateStarts();

			try {
				Date date = new SimpleDateFormat("dd-MM-yyyy' в 'HH:mm")
						.parse(dateS);
				Date today = new Date();
				if (today.before(date))
					event.setActive(true);
				else
					event.setActive(false);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		 
		return eventList;
	}
}
