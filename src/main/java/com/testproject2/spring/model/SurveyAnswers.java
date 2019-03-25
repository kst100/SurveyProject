package com.testproject2.spring.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="survey_answers")
public class SurveyAnswers {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private Integer survey_id;
	private Integer user_id;
	private Integer question_id;
	private Integer answer_id;
	private String open_answer;
	private String is_valid;
	private Date created;	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getSurvey_id() {
		return survey_id;
	}
	public void setSurvey_id(Integer survey_id) {
		this.survey_id = survey_id;
	}
	public Integer getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	public Integer getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(Integer question_id) {
		this.question_id = question_id;
	}
	public Integer getAnswer_id() {
		return answer_id;
	}
	public void setAnswer_id(Integer answer_id) {
		this.answer_id = answer_id;
	}
	public String getOpen_answer() {
		return open_answer;
	}
	public void setOpen_answer(String open_answer) {
		this.open_answer = open_answer;
	}
	public String getIs_valid() {
		return is_valid;
	}
	public void setIs_valid(String is_valid) {
		this.is_valid = is_valid;
	}
	public Date getCreated() {
		return created;
	}
	public void setCreated(Date created) {
		this.created = created;
	}
}
