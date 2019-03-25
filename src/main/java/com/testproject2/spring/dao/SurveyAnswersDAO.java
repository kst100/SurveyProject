package com.testproject2.spring.dao;

import java.util.List;

import com.testproject2.spring.model.SurveyAnswers;
import com.testproject2.spring.model.SurveyAnswersDetails;

public interface SurveyAnswersDAO {
	public List<SurveyAnswers> getSurveyAnswers();
	public SurveyAnswers getSurveyAnswer(int id);
	public List<SurveyAnswersDetails> getSurveyAnswersDetails();
	public void saveSurveyAnswer (SurveyAnswers surveyAnswer);
	public void deleteSurveyAnswer (int id);
}
