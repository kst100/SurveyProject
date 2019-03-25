package com.testproject2.spring.services;

import java.sql.Timestamp;
import java.time.Instant;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.testproject2.spring.dao.SurveyAnswersDAO;
import com.testproject2.spring.model.SurveyAnswers;
import com.testproject2.spring.model.SurveyAnswersDetails;

@Transactional
@Service
public class SurveyAnswersServiceImpl implements SurveyAnswersService {

	@Autowired	
	private SurveyAnswersDAO surveyAnswersDAO; 
	
	@Override
	public List<SurveyAnswers> getSurveyAnswers() {
		return surveyAnswersDAO.getSurveyAnswers(); 
	}

	@Override
	public SurveyAnswers getSurveyAnswer(int id) {
		return surveyAnswersDAO.getSurveyAnswer(id);
	}

	@Override
	public List<SurveyAnswersDetails> getSurveyAnswersDetails() {
		return surveyAnswersDAO.getSurveyAnswersDetails();  
	}	
	
	@SuppressWarnings("unchecked")
	@Override
	public void saveSurveyAnswer(HttpSession httpSession) {
		
		//Get Data from session
		Integer survey_id = (Integer)httpSession.getAttribute("survey_id");
		Integer user_id = (Integer)httpSession.getAttribute("user_id");
		Integer question_id;
		Integer answer_id;
		String  open_answer;
		String  is_valid = "T";
		String expirationDate = (String) httpSession.getAttribute("survey_expiration");
		Date created = new Date();
		SurveyAnswers surveyAnswers;
		
		java.sql.Timestamp ts = Timestamp.valueOf(expirationDate);
		java.time.Instant instant = ts.toInstant();
		Instant now = Instant.now();
		Boolean isStoredDateTimePast = now.isAfter( instant );
		if(isStoredDateTimePast) is_valid = "F";
		
		Enumeration<String> keys = httpSession.getAttributeNames();
		while (keys.hasMoreElements()) {
			// make save for the iterator also
			String key = keys.nextElement().toString();
			if(key.contains("answer")) {
				// Get all the answers	
				question_id = Integer.parseInt(key.substring(7, key.length()-3));
				LinkedList<String> answers = (LinkedList<String>) httpSession.getAttribute(key); 
				Iterator<String> listItertator = answers.iterator();
				while (listItertator.hasNext()) {
					surveyAnswers = new SurveyAnswers();
					surveyAnswers.setSurvey_id(survey_id);
					surveyAnswers.setUser_id(user_id);			
					surveyAnswers.setQuestion_id(question_id);
					answer_id = Integer.parseInt(listItertator.next().toString());
					surveyAnswers.setAnswer_id(answer_id);
					surveyAnswers.setIs_valid(is_valid);
					surveyAnswers.setCreated(created);
					surveyAnswersDAO.saveSurveyAnswer(surveyAnswers);
				}	
			}
			if(key.contains("open")) {
				surveyAnswers = new SurveyAnswers();
				surveyAnswers.setSurvey_id(survey_id);
				surveyAnswers.setUser_id(user_id);			
				question_id = Integer.parseInt(key.substring(5, key.length()-1));
				surveyAnswers.setQuestion_id(question_id);
				open_answer = httpSession.getAttribute(key).toString();
				surveyAnswers.setAnswer_id(null);
				surveyAnswers.setOpen_answer(open_answer);
				surveyAnswers.setIs_valid(is_valid);
				surveyAnswers.setCreated(created);
				surveyAnswersDAO.saveSurveyAnswer(surveyAnswers);
			}
		}		
	}

	@Override
	public void deleteSurveyAnswer(int id) {
		surveyAnswersDAO.deleteSurveyAnswer(id);
	}

}
