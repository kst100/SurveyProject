package com.testproject2.spring.dao;

import java.util.List;

import com.testproject2.spring.model.Answer;

public interface AnswerDAO {
	public List<Answer> getAnswers(Integer qid);
	public Answer getAnswer(int aid);
	public void saveAnswer (Answer answer);
	public void deleteAnswer (int aid);
	public void deleteAnswerFile (int aid);
}
