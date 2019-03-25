package com.testproject2.spring.model;

public class SurveyAnswersDetails {
	
	private Integer id;
	private String surveyTitle;
	private String userName;
	private String created;
	
	public SurveyAnswersDetails(Integer id, String created, String surveyTitle, String userName) {
		this.setId(id);
		this.setCreated(created);
		this.setSurveyTitle(surveyTitle);
		this.setUserName(userName);
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getSurveyTitle() {
		return surveyTitle;
	}
	public void setSurveyTitle(String surveyTitle) {
		this.surveyTitle = surveyTitle;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
}