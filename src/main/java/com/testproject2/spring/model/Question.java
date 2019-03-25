package com.testproject2.spring.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="questions")
public class Question {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private int survey_id;
	private String title;
	private String description;
	private String type;
	private String filepath;
	private String is_required;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSurvey_id() {
		return survey_id;
	}
	public void setSurvey_id(int survey_id) {
		this.survey_id = survey_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}	
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getIs_required() {
		return is_required;
	}
	public void setIs_required(String is_required) {
		this.is_required = is_required;
	}	
}
