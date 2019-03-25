package com.testproject2.spring.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.testproject2.spring.dao.SurveyDAO;
import com.testproject2.spring.model.Survey;

@Repository
public class SurveyDAOImpl implements SurveyDAO {

	@Autowired
	private SessionFactory factory;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Survey> getSurveys() {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("from Survey S ORDER BY S.id DESC");
		List<Survey> surveys = theQuery.list();
		return surveys;		
	}

	@Override
	public void saveSurvey(Survey newSurvey) {
		Session session = factory.getCurrentSession();
		Date date= new Date();
		long time = date.getTime();
		Timestamp ts = new Timestamp(time);
		newSurvey.setDateOfOrder(ts);		
		session.saveOrUpdate(newSurvey);
	}

	@Override
	public Survey getSurvey(int id) {
		Session session = factory.getCurrentSession();
		Survey survey = session.get(Survey.class, id);
		if(survey != null){
            Hibernate.initialize(survey.getUsersPerSurvey());
        }
		return survey;		
	}

	@Override
	public void deleteSurvey(int id) {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("delete from Survey where id=:Id");
		theQuery.setParameter("Id", id);
		theQuery.executeUpdate();
	}
}
