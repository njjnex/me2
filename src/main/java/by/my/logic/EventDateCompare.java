package by.my.logic;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Comparator;
import java.util.Date;

import by.my.entity.Event;

public class EventDateCompare implements Comparator<Event> {

	@Override
	public int compare(Event o1, Event o2) {
		String dateS1 = o1.getDateStarts();
		String dateS2 = o2.getDateStarts();

		DateFormat format = new SimpleDateFormat("dd-MM-yyy 'в' HH:mm");
		Date date1 = null;
		Date date2 = null;
		try {
			date1 = format.parse(dateS1);
			date2 = format.parse(dateS2);
		} catch (Exception e) {
			e.printStackTrace();
		}
		o1.setCompare(date1);
		o2.setCompare(date2);
		return o1.getCompare().compareTo(o2.getCompare());
	}

}
