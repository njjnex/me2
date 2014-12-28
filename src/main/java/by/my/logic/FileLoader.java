package by.my.logic;

import java.util.Iterator;
import java.util.Set;

import by.my.entity.Event;
import by.my.entity.User;

/*This class generates String from user event 
details

params: 
@User is param is USer why detail should be shown
return the String whith user params
*/

	public class FileLoader {

	public String userString(User user) {

		StringBuilder a = new StringBuilder();
				
		a.append("Пользователь: ");
		a.append(user.getUsername());
				
		Set<Event> events = (Set<Event>) user.getUserCreatedEvents();
		Iterator<Event> it = events.iterator();
		
		while(it.hasNext()){
			Event event = it.next();
			
			a.append(System.lineSeparator());
			a.append("----------------");
			a.append(System.lineSeparator());
			a.append("Мероприятие: ");
			a.append(event.getEventName());
			a.append(System.lineSeparator());
			a.append("Зарегистрировались: ");
			
				Set<User> users = (Set<User>) event.getEventMembersJoined();
				Iterator<User> iter = users.iterator();
				
				while(iter.hasNext()){
					User userJ = iter.next();
					
					a.append(System.lineSeparator());
					a.append("Имя: " + userJ.getUsername() + "| телефон: " + userJ.getPhone());
					a.append(System.lineSeparator());
				}
		}
		String result = a.toString();
		
		return result;
	}
}
