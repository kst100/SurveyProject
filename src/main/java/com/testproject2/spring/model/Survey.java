package com.testproject2.spring.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="surveys")
public class Survey {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	private String name;
	private String description;

	@Column(name="created")
	private Date dateOfOrder;	

	@Column(name="expiration_dt")
	@DateTimeFormat(pattern = "yyyy-MM-DD H:i:s")
	private String expirationDate; 

    @ManyToMany(fetch = FetchType.LAZY, cascade=CascadeType.ALL)
    @JoinTable(name = "users_surveys",
            joinColumns = { @JoinColumn(name = "survey_id") },
            inverseJoinColumns = { @JoinColumn(name = "user_id") })
    private Set<User> usersPerSurvey = new HashSet<>();	
 

	public Survey(){
		// constructor
	}	
	
	// Very important! Used by Spring to generate Objects and not String to Set error
    public Survey(String name) {
        this.name = name;
    }	
	
	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String surveyName) {
		this.name = surveyName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public Date getDateOfOrder() {
		return dateOfOrder;
	}

	public void setDateOfOrder(Date dateOfOrder) {
		this.dateOfOrder = dateOfOrder;
	}

	public String getExpirationDate() {
		return expirationDate;
	}

	public void setExpirationDate(String expirationDate) {
		this.expirationDate = expirationDate;
	}
	
	public Set<User> getUsersPerSurvey() {
		return usersPerSurvey;
	}

	public void setUsersPerSurvey(Set<User> usersPerSurvey) {
		this.usersPerSurvey = usersPerSurvey;
	}	
}
