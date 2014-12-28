package by.my.entity;

import java.sql.Blob;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "USER")
public class User{
	
	@Id
	@GeneratedValue
	@Column(name = "USER_ID")
	private long id;
	
	@Column(name = "USERNAME")
	private String username;
	
	@Column(name = "PASSWORD")
	private String password;
	
	@Column(name = "EMAIL")
	private String email;
	@OneToMany(mappedBy="createdBy", cascade=CascadeType.ALL,fetch=FetchType.EAGER)
	private Set<Event> userCreatedEvents = new HashSet<Event>(); 
	@ManyToMany(mappedBy="eventMembersJoined",cascade={CascadeType.DETACH, CascadeType.MERGE, CascadeType.REFRESH}, fetch=FetchType.EAGER)
	private Set<Event> userJoinedEvents = new HashSet<Event>();
	@Column(name = "ENABLED")
	private boolean enabled;
	@Column(name= "PHONE")
	private String phone;
	@Column(name= "GENDER")
	private String gender;
	@Column(name= "AGE")
	private String age;
	@Column(name = "ROLE")
    private String userRole;
	@Lob
	@Column(name="AVATAR")
	private Blob avatar;
	@Column(name = "IS_AVATAR_LODED") 
	private boolean avatarLoded = false;
	
	public boolean isAvatarLoded() {
		return avatarLoded;
	}
	public void setAvatarLoded(boolean avatarLoded) {
		this.avatarLoded = avatarLoded;
	}
	public Blob getAvatar() {
		return avatar;
	}
	public void setAvatar(Blob avatar) {
		this.avatar = avatar;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Set<Event> getUserCreatedEvents() {
		return userCreatedEvents;
	}
	public void setUserCreatedEvents(Set<Event> userCreatedEvents) {
		this.userCreatedEvents = userCreatedEvents;
	}
	public Set<Event> getUserJoinedEvents() {
		return userJoinedEvents;
	}
	public void setUserJoinedEvents(Set<Event> userJoinedEvents) {
		this.userJoinedEvents = userJoinedEvents;
	}
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	
	
}