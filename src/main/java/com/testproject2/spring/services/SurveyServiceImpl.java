package com.testproject2.spring.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.testproject2.spring.dao.SurveyDAO;
import com.testproject2.spring.model.Survey;
import com.testproject2.spring.services.SurveyService;

@Transactional
@Service
public class SurveyServiceImpl implements SurveyService {

	@Autowired	
	private SurveyDAO surveyDAO; 
	
	@Override
	public List<Survey> getSurveys() {
		return surveyDAO.getSurveys();
	}

	@Override
	public void saveSurvey(Survey newSurvey) {
		surveyDAO.saveSurvey(newSurvey);	
	}

	@Override
	public Survey getSurvey(int id) {
		return surveyDAO.getSurvey(id);
	}

	@Override
	public void deleteSurvey(int id) {
		surveyDAO.deleteSurvey(id);	
	}
}