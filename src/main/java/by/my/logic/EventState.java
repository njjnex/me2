package by.my.logic;

import java.util.Iterator;
import java.util.List;

import by.my.entity.Event;

public class EventState {

	public List<Event> isActive(List<Event> eventList) {
		
		for (Iterator<Event> iterator = eventList.iterator(); iterator.hasNext(); ) {
			Event event = iterator.next();
			if (!event.isActive())
				iterator.remove();
		}

		return eventList;
	}
	public List<Event> isUnactive(List<Event> eventList) {
		
		for (Iterator<Event> iterator = eventList.iterator(); iterator.hasNext(); ) {
			Event event = iterator.next();
			if (event.isActive())
				iterator.remove();
		}

		return eventList;
	}
}
