package com.testproject2.spring.services;

import java.util.List;
import com.testproject2.spring.model.Survey;

public interface SurveyService {

	 public List<Survey> getSurveys();
	 public void saveSurvey(Survey newSurvey);
	 public Survey getSurvey(int id);
	 public void deleteSurvey(int id);	
}
