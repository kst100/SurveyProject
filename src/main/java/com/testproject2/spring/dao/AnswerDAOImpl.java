package com.testproject2.spring.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.testproject2.spring.model.Answer;

@Repository
public class AnswerDAOImpl implements AnswerDAO {

	@Autowired
	private SessionFactory factory;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Answer> getAnswers(Integer qid) {
		Session session = factory.getCurrentSession();
		Query theQuery;
		if(qid == null || qid == 0) {  
			theQuery = session.createQuery("from Answer A ORDER BY A.id ASC");
		} else {
			theQuery = session.createQuery("from Answer A WHERE A.question_id = :qid ORDER BY A.id ASC");
			theQuery.setParameter("qid", qid);
		} 
		List<Answer> answers = theQuery.list();
		return answers;	
	}

	@Override
	public Answer getAnswer(int id) {
		Session session = factory.getCurrentSession();
		return session.get(Answer.class, id);
	}

	@Override
	public void saveAnswer(Answer answer) {
		Session session = factory.getCurrentSession();
		session.saveOrUpdate(answer);
	}

	@Override
	public void deleteAnswer(int id) {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("delete from Answer where id=:Id");
		theQuery.setParameter("Id", id);
		theQuery.executeUpdate();	
	}

	@Override
	public void deleteAnswerFile(int aid) {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("UPDATE Answer SET filepath = '' where id=:Id");
		theQuery.setParameter("Id", aid);
		theQuery.executeUpdate();	
	}

}
