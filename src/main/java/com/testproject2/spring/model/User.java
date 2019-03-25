package com.testproject2.spring.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="users")
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	private String fName;
	private String lName;
	private String email;
	private String pass;
	private String phone;
	private String address;
	
	@DateTimeFormat(pattern = "yyyy-MM-DD H:i:s")
	private Date modified;

    @ManyToMany(mappedBy = "usersPerSurvey", cascade = CascadeType.ALL)
    private Set<Survey> surveys = new HashSet<Survey>();	
	
	public User(){
		// constructor
	}	
	
	public User(String name){
		this.fName = name;
	}	
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getlName() {
		return lName;
	}

	public void setlName(String lName) {
		this.lName = lName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}
	
	public Set<Survey> getSurveys() {
		return surveys;
	}

	public void setSurveys(Set<Survey> surveys) {
		this.surveys = surveys;
	}	
}
