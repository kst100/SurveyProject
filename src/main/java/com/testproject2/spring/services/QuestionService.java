package com.testproject2.spring.services;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.testproject2.spring.model.Question;
import com.testproject2.spring.services.QuestionServiceImpl.QuestionsReport;

public interface QuestionService {
	public List<Question> getQuestions(Integer sid);
	public Question getQuestion(int id);
	public void saveQuestion(Question newQuestion, MultipartFile file);
	public void deleteQuestion(int id);
	public void deleteQuestionFile(int qid, boolean updateQqery);
	public Integer getAnswersCount(int sid);
	public List<QuestionsReport> getAnswersReport(int qid);
}
