package by.my.logic;

import java.util.Comparator;

import by.my.entity.Event;

public class EventStateCompare implements Comparator<Event> {

	@Override
	public int compare(Event o1, Event o2) {

		boolean v1 = o1.isActive();
		boolean v2 = o2.isActive();
		if (v1 && !v2) {
			return -1;
		}
		if (!v1 && v2) {
			return +1;
		}
		return 0;
	}

}
