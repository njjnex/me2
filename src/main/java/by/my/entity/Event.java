package by.my.entity;

import java.sql.Blob;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "EVENT")
public class Event{
	@Id
	@GeneratedValue
	@Column(name = "EVENT_ID")
	private long id;
	@Column(name = "EVENT_NAME")
	private String eventName;
	@Column(name = "EVENT_STARTDATE")
	private String dateStarts;
	@ManyToMany(cascade = {CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.EAGER)
	@JoinTable(name="MEMBERS_JOINED_EVENT", 
	                joinColumns={@JoinColumn(name="JOINED_EVENT_ID")}, 
	                inverseJoinColumns={@JoinColumn(name="USER_ID")})
	private Set<User> eventMembersJoined = new HashSet<User>();
	@Column(name = "EVENT_MEMBERS")
	private int eventMembersCount;
	@ManyToOne
	@JoinColumn(name = "CREATED_BY", nullable = true)
	private User createdBy;
	@Lob
	@Column(name = "EVENT_IMAGE") 
	private Blob image;
	@Column(name = "EVENT_STATUS") 
	private boolean active = true;
	@Column(name = "IS_IMAGE_LODED") 
	private boolean imageLoded = false;
	@Column(name = "DESCRIPTION") 
	private String description;
	@Column(name="PLACE")
	private String place;
	@OneToMany(mappedBy = "event", fetch=FetchType.LAZY)
	private Set<Message> messages;
	
		
	public Set<Message> getMessages() {
		return messages;
	}
	public void setMessages(Set<Message> messages) {
		this.messages = messages;
	}
	public String getPlace() {
		return place;
	}
	public void setPlace(String place) {
		this.place = place;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public boolean isImageLoded() {
		return imageLoded;
	}
	public void setImageLoded(boolean imageLoded) {
		this.imageLoded = imageLoded;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	public String getDateStarts() {
		return dateStarts;
	}
	public void setDateStarts(String dateStarts) {
		this.dateStarts = dateStarts;
	}
	public Set<User> getEventMembersJoined() {
		return eventMembersJoined;
	}
	public void setEventMembersJoined(Set<User> eventMembersJoined) {
		this.eventMembersJoined = eventMembersJoined;
	}
	public int getEventMembersCount() {
		return eventMembersCount;
	}
	public void setEventMembersCount(int eventMembersCount) {
		this.eventMembersCount = eventMembersCount;
	}
	public User getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(User createdBy) {
		this.createdBy = createdBy;
	}
	public Blob getImage() {
		return image;
	}
	public void setImage(Blob image) {
		this.image = image;
	}
}
