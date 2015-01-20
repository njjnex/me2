package by.my.logic;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;

import by.my.entity.Event;

/**
 * @author njjnex Helper class that do some special event logic.
 */
@Service
public class EventState {

	/**
	 * Checks if event is up to date or it have been already passed
	 * @return list of events in future
	 */
	public List<Event> isActive(List<Event> eventList) {
		for (Iterator<Event> iterator = eventList.iterator(); iterator
				.hasNext();) {
			Event event = iterator.next();
			if (!event.isActive())
				iterator.remove();
		}
		return eventList;
	}
	/**
	 * Checks if event is up to date or it have been already passed
	 * @return list of passed events
	 */
	public List<Event> isUnactive(List<Event> eventList) {
		for (Iterator<Event> iterator = eventList.iterator(); iterator
				.hasNext();) {
			Event event = iterator.next();
			if (event.isActive())
				iterator.remove();
		}
		return eventList;
	}
	/**
	 *  The logic that checks if event is active by comparing today date with event dateStarts
	 *  if it's not than mark this event state as unactive and save it to db.
	 *  @ param eventList list of all events
	 *  @return eventlist list of all events with set params if they active ir not
	 */
	public List<Event> upToDateEvents(List<Event> eventList) {

		for (Event event : eventList) {
			String dateS = event.getDateStarts();

			try {
				Date date = new SimpleDateFormat("dd-MM-yyyy' в 'HH:mm")
						.parse(dateS);
				Date today = new Date();
				if (!today.before(date)) {
					event.setActive(false);
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		return eventList;
	}
}
