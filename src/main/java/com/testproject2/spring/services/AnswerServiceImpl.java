package com.testproject2.spring.services;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.testproject2.spring.dao.AnswerDAO;
import com.testproject2.spring.model.Answer;

@Transactional
@Service
public class AnswerServiceImpl implements AnswerService {

	@Autowired	
	private AnswerDAO answerDAO;

    @Value("${fileUploadServerPath}")
    private String server_path;	
    
	@Override
	public List<Answer> getAnswers(Integer aid) {
		return answerDAO.getAnswers(aid);
	}

	@Override
	public Answer getAnswer(int aid) {
		return answerDAO.getAnswer(aid);
	}

	@Override
	public void saveAnswers(List<Answer> answers, int qid, String delete_answers, List<MultipartFile> files) {
		
		Map<Integer, String> fileNames = new HashMap<Integer, String>();
		if(null != files && files.size() > 0) {
			for (MultipartFile multipartFile : files) {

				if (multipartFile != null && !multipartFile.isEmpty()) {
				  try {
					  	String filepath = multipartFile.getOriginalFilename();
						File transferFile = new File(server_path + "upload/answers/" + filepath); 
						multipartFile.transferTo(transferFile);
						fileNames.put(files.indexOf(multipartFile), filepath);
					} catch (Exception e) { 
						e.printStackTrace();
					}
				}
			}
		}		
		
		int answer_index = -1;
		String filepath = null;
		if(null != answers && answers.size() > 0) {
			for (Answer newAnswer : answers) {
				answer_index = answers.indexOf(newAnswer);
				filepath = fileNames.get(answer_index);
				if(newAnswer.getId() == 0 && newAnswer.getQuestion_id() == 0) {
					// continue	
				} else {	
					if(filepath != null) newAnswer.setFilepath(filepath);
					answerDAO.saveAnswer(newAnswer);
				}
			}
		}

		if(!delete_answers.equals("")) {
			int aid = 0;
			String[] data = delete_answers.split(",");
			for (String el : data) {
				aid = Integer.parseInt(el);
				this.deleteAnswerFile(aid, false);
				answerDAO.deleteAnswer(aid);
			}	
		} 
	}
	
	@Override
	public void saveAnswer(Answer answer) { 
		answerDAO.saveAnswer(answer);
	}

	@Override
	public void deleteAnswers(int qid) {
		List<Answer> all_answers = answerDAO.getAnswers(qid);
		for (Answer delAnswer : all_answers) {
			this.deleteAnswerFile(delAnswer.getId(), false);
			answerDAO.deleteAnswer(delAnswer.getId());
		}		
	}
	
	@Override
	public void deleteAnswer(int aid) {
		this.deleteAnswerFile(aid, false);
		answerDAO.deleteAnswer(aid);		
	}

	@Override 
	public void deleteAnswerFile(int aid, boolean updateQuery) {
		Answer q = answerDAO.getAnswer(aid);
	  	File savedFile = new File(server_path + "upload/answers/" + q.getFilepath());
	  	
	  	boolean deleted = false;
		if (savedFile.exists() && savedFile.isFile()) {
			deleted = savedFile.delete();
		}		
		
		if (updateQuery && deleted) answerDAO.deleteAnswerFile(aid);
	}

}
