package by.my.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "MESSAGE")
public class Message {
	@Id
	@GeneratedValue
	@Column(name = "MESSAGE_ID")
	private long id;
	@Column(name = "DATE")
	private String date;
	@Column(name = "TEXT")
	private String text;
	@OneToOne
	@JoinColumn(name="AUTHOR_ID", referencedColumnName="USER_ID")
	private User author;
	@ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
	@JoinColumn(name="EVENT_ID", referencedColumnName="EVENT_ID")
	private Event event;
	

	
	public Event getEvent() {
		return event;
	}

	public void setEvent(Event event) {
		this.event = event;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public User getAuthor() {
		return author;
	}

	public void setAuthor(User author) {
		this.author = author;
	}

}
