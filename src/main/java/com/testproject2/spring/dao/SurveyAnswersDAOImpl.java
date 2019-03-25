package com.testproject2.spring.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.testproject2.spring.model.SurveyAnswers;
import com.testproject2.spring.model.SurveyAnswersDetails;

@Repository
public class SurveyAnswersDAOImpl implements SurveyAnswersDAO {

	@Autowired
	private SessionFactory factory;	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<SurveyAnswers> getSurveyAnswers() {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("from SurveyAnswers SA ORDER BY SA.id ASC");
		List<SurveyAnswers> surveyAnswers = theQuery.list();
		return surveyAnswers;	
	}

	@Override
	public SurveyAnswers getSurveyAnswer(int id) {
		Session session = factory.getCurrentSession();
		return session.get(SurveyAnswers.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<SurveyAnswersDetails> getSurveyAnswersDetails() {
		Session session = factory.getCurrentSession();
		
		Integer id;
		String created;
		String surveyTitle;
		String userName;
		SurveyAnswersDetails surveyAnswer;
		List<SurveyAnswersDetails>surveyAnswers = new ArrayList<SurveyAnswersDetails>();
		
		Query theQuery = session.createQuery("SELECT t1.id, t1.created, t2.name AS surveyTitle, CONCAT(t3.fName, ' ', t3.lName) AS userName FROM SurveyAnswers t1 INNER JOIN Survey t2 ON t2.id = t1.survey_id INNER JOIN User t3 ON t3.id = t1.user_id GROUP BY t1.created ORDER BY t1.id ASC");
		List<Object> rows = theQuery.list(); 
		for (Object object : rows) {
	          Object[] result = (Object[]) object;
	          id = Integer.parseInt(result[0].toString());
	          created = result[1].toString();
	          surveyTitle = result[2].toString();
	          userName = result[3].toString();
	          surveyAnswer = new SurveyAnswersDetails(id, created, surveyTitle, userName);
	          surveyAnswers.add(surveyAnswer);
		}		
		return surveyAnswers;	
	}
	
	@Override
	public void saveSurveyAnswer(SurveyAnswers surveyAnswer) {
		Session session = factory.getCurrentSession();
		session.saveOrUpdate(surveyAnswer);
	}

	@Override
	public void deleteSurveyAnswer(int id) {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("delete from SurveyAnswers where id=:Id");
		theQuery.setParameter("Id", id);
		theQuery.executeUpdate();	
	}

}
