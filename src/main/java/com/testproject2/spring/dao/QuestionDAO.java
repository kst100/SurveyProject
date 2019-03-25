package com.testproject2.spring.dao;

import java.util.List;
import com.testproject2.spring.model.Question;

public interface QuestionDAO {
	public List<Question> getQuestions(Integer sid);
	public Question getQuestion(int id);
	public void saveQuestion(Question newQuestion);
	public void deleteQuestion(int id);
	public void deleteQuestionFile(int qid);
	public Integer getAnswersCount(int qid);
	public List<Object> getAnswersReport(int qid);
}
