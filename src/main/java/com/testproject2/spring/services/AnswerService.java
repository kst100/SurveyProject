package com.testproject2.spring.services;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.testproject2.spring.model.Answer;

public interface AnswerService {
	public List<Answer> getAnswers(Integer qid);
	public Answer getAnswer(int aid);
	public void saveAnswer (Answer answer);
	public void saveAnswers (List<Answer> answers, int qid, String answersForDelete, List<MultipartFile> files); 
	public void deleteAnswer (int aid);
	public void deleteAnswerFile (int aid, boolean updateQqery);
	public void deleteAnswers(int qid);
}
