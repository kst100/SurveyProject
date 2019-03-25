package com.testproject2.spring.services;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.testproject2.spring.model.Question;
import com.testproject2.spring.services.QuestionService;
import com.testproject2.spring.dao.QuestionDAO; 

@Transactional
@Service
public class QuestionServiceImpl implements QuestionService {

	@Autowired	
	private QuestionDAO questionDAO;
	
    @Value("${fileUploadServerPath}")
    private String server_path;	
    
	@Override
	public List<Question> getQuestions(Integer sid) {
		return questionDAO.getQuestions(sid);
	}

	@Override
	public Question getQuestion(int id) {
		return questionDAO.getQuestion(id);
	}

	@Override
	public void saveQuestion(Question question, MultipartFile file) {
		  
		if (!file.isEmpty()) {
		  try {
			  	String filepath = file.getOriginalFilename();
				File transferFile = new File(server_path + "upload/questions/" + filepath); 
				file.transferTo(transferFile);
				question.setFilepath(filepath);
			} catch (Exception e) { 
				e.printStackTrace();
			}
		}		
		questionDAO.saveQuestion(question);
	}

	@Override
	public void deleteQuestion(int id) {
		this.deleteQuestionFile(id, false);
		questionDAO.deleteQuestion(id);
	}

	@Override
	public void deleteQuestionFile(int qid, boolean updateQuery) {
		
		Question q = questionDAO.getQuestion(qid);
	  	File savedFile = new File(server_path + "upload/questions/" + q.getFilepath());
	  	
	  	boolean deleted = false;
		if (savedFile.exists() && savedFile.isFile()) {
			deleted = savedFile.delete();
		}		
		
		if (updateQuery && deleted) questionDAO.deleteQuestionFile(qid);
	}	
	
	@Override
	public Integer getAnswersCount(int sid) {
		Integer maxCnt = questionDAO.getAnswersCount(sid);
		return maxCnt;
	}
	
	@Override
	public List<QuestionsReport> getAnswersReport(int qid) {
		
		List<QuestionsReport> questionsReports = new ArrayList<QuestionsReport>();
		QuestionsReport questionsReport;
		Integer answer_id = 0, cnt = 0;
		List<Object> answersReport = questionDAO.getAnswersReport(qid);
		for (Object object : answersReport) {
	          Object[] result = (Object[]) object;
	          answer_id = Integer.parseInt(result[0].toString());
	          cnt = Integer.parseInt(result[1].toString());
	          questionsReport = new QuestionsReport(qid, answer_id, cnt);
	          questionsReports.add(questionsReport);
		}		
		return questionsReports;
	}
	
	public class QuestionsReport {
		
		private Integer question_id;
		private Integer answer_id;
		private Integer cnt;
		  
		public QuestionsReport(Integer question_id, Integer answer_id, Integer cnt) {
			  this.question_id = question_id;
			  this.answer_id = answer_id;
			  this.cnt = cnt;
		}

		public Integer getQuestion_id() {
			return question_id;
		}

		public void setQuestion_id(Integer question_id) {
			this.question_id = question_id;
		}

		public Integer getAnswer_id() {
			return answer_id;
		}

		public void setAnswer_id(Integer answer_id) {
			this.answer_id = answer_id;
		}

		public Integer getCnt() {
			return cnt;
		}

		public void setCnt(Integer cnt) {
			this.cnt = cnt;
		}
	}	
}
