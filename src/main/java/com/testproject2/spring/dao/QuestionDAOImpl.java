package com.testproject2.spring.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.testproject2.spring.model.Question;

@Repository
public class QuestionDAOImpl implements QuestionDAO {

	@Autowired
	private SessionFactory factory;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Question> getQuestions(Integer sid) {
		Session session = factory.getCurrentSession();
		Query theQuery;
		if(sid == null || sid == 0) {  
			theQuery = session.createQuery("from Question Q ORDER BY Q.id ASC");
		} else {
			theQuery = session.createQuery("from Question Q WHERE Q.survey_id = :sid ORDER BY Q.id ASC");
			theQuery.setParameter("sid", sid);
		} 
		List<Question> questions = theQuery.list();
		return questions;		
	}

	@Override
	public Question getQuestion(int id) {
		Session session = factory.getCurrentSession();
		return session.get(Question.class, id);
	}

	@Override
	public void saveQuestion(Question newQuestion) {
		Session session = factory.getCurrentSession();
		session.saveOrUpdate(newQuestion);
	}

	@Override
	public void deleteQuestion(int id) {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("delete from Question where id=:Id");
		theQuery.setParameter("Id", id);
		theQuery.executeUpdate();		
	}

	@Override	
	public void deleteQuestionFile(int qid) {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("UPDATE Question SET filepath = '' where id=:Id");
		theQuery.setParameter("Id", qid);
		theQuery.executeUpdate();		
	}	
	
	@SuppressWarnings("unchecked")
	@Override	
	public Integer getAnswersCount(int sid) {
		Session session = factory.getCurrentSession();
		// hibernate does not support subqueries inside aggregate functions, because some DBs don't support it
		Query theQuery = session.createQuery("SELECT t1.id, (SELECT COUNT(*) FROM Answer t2 WHERE t2.question_id = t1.id ) AS cnt_answers FROM Question t1 WHERE survey_id=:sid");
		theQuery.setParameter("sid", sid);
		List<Object> answersCount = theQuery.list();
		Integer maxAnswersCount = 0, nextCount = 0;
	    for (Object object : answersCount) {
	          Object[] result = (Object[]) object;
	          nextCount = Integer.parseInt(result[1].toString());
	          if(maxAnswersCount < nextCount) maxAnswersCount = nextCount;
	    }		
		return maxAnswersCount; 
	}
	
	@SuppressWarnings("unchecked")
	@Override	
	public List<Object> getAnswersReport(int qid) {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("SELECT t1.id, (SELECT COUNT(*) FROM SurveyAnswers t2 WHERE t2.answer_id = t1.id AND t2.is_valid = 'T') AS cnt FROM Answer t1 WHERE t1.question_id = :qid");
		theQuery.setParameter("qid", qid);
		List<Object> questionReport = theQuery.list();
		return questionReport;			
	}	
}
