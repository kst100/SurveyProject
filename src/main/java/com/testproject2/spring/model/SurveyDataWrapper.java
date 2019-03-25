package com.testproject2.spring.model;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import com.testproject2.spring.model.QuestionsListWrapper;
import com.testproject2.spring.services.AnswerService;

public class SurveyDataWrapper {

	private Survey survey;
	private User user;
	private LinkedList<QuestionsListWrapper> questionsList;
	
	public Survey getSurvey() {
		return survey;
	}
	public void setSurvey(Survey survey) {
		this.survey = survey;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public LinkedList<QuestionsListWrapper> getQuestionsList() {
		return questionsList;
	}
	public void setQuestionsList(LinkedList<QuestionsListWrapper> questionsList) {
		this.questionsList = questionsList;
	}

	public void setQuestions(List<Question> questions, AnswerService answerService) {
		QuestionsListWrapper questionWrapper = null;
		LinkedList<QuestionsListWrapper> questionWrapperList = new LinkedList<QuestionsListWrapper>();
		List<Answer> answers = new ArrayList<Answer>(); 
		
		for( Question question : questions) {
			answers = answerService.getAnswers(question.getId());
			questionWrapper = new QuestionsListWrapper(question, answers); 
			questionWrapperList.add(questionWrapper);
		}	
		this.setQuestionsList(questionWrapperList);
	}	
}
