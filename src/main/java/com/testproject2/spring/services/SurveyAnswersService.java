package com.testproject2.spring.services;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.testproject2.spring.model.SurveyAnswers;
import com.testproject2.spring.model.SurveyAnswersDetails;

public interface SurveyAnswersService {
	public List<SurveyAnswers> getSurveyAnswers(); 
	public SurveyAnswers getSurveyAnswer(int id);
	public void saveSurveyAnswer (HttpSession httpSession);
	public void deleteSurveyAnswer (int id);
	public List<SurveyAnswersDetails> getSurveyAnswersDetails();
}
