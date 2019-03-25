package com.testproject2.spring.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.testproject2.spring.model.User;

@Repository
public class UserDAOImpl implements UserDAO { 

	@Autowired
	private SessionFactory factory;
	
	@SuppressWarnings("unchecked")
	@Override
	public List<User> getUsers() {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("from User U ORDER BY U.fName ASC");
		List<User> users = theQuery.list();
		return users;	
	}

	@Override
	public void saveUser(User newUser) {
		Session session = factory.getCurrentSession();
		
		// modified date and time
		Date date= new Date();
		long time = date.getTime();
		Timestamp ts = new Timestamp(time);
		newUser.setModified(ts);
		
		session.saveOrUpdate(newUser);		
	}

	@Override
	public User getUser(int id) {
		Session session = factory.getCurrentSession();
		return session.get(User.class, id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public User getUser(String email, String pass) {
		User user = null;
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("from User U where email = :Email AND pass = :Pass");
		theQuery.setParameter("Email", email);
		theQuery.setParameter("Pass", pass);
		List<User> userObj = theQuery.list();
		if (userObj != null && userObj.size() > 0) {
			user = userObj.get(0);
		}
		return user;
	}
	
	@Override
	public void deleteUser(int id) {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("delete from User where id=:Id");
		theQuery.setParameter("Id", id);
		theQuery.executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Boolean checkUser(String email) {
		Session session = factory.getCurrentSession();
		Query theQuery = session.createQuery("from User U where email = :Email");
		theQuery.setParameter("Email", email);
		List<User> users = theQuery.list();
		if (users.size() > 0) {
			return true;	
		} else {
			return false;
		}		
		
	}	
}
