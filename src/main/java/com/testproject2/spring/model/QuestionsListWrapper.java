package com.testproject2.spring.model;

import java.util.List;

public class QuestionsListWrapper {

	private Question question;
	private List<Answer> answers;
	
	public QuestionsListWrapper(Question question, List<Answer> answers) {
		this.setQuestion(question);
		this.setAnswers(answers);
	}
	public Question getQuestion() {
		return question;
	}
	public void setQuestion(Question question) {
		this.question = question;
	}
	public List<Answer> getAnswers() {
		return answers;
	}
	public void setAnswers(List<Answer> answers) {
		this.answers = answers;
	}
}
