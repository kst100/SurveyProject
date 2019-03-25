package com.testproject2.spring.services;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.testproject2.spring.dao.UserDAO;
import com.testproject2.spring.model.Survey;
import com.testproject2.spring.model.User;

@Transactional
@Service
public class UserServiceImpl implements UserService {

	@Autowired	
	private UserDAO userDAO;
	
	@Override
	public List<User> getUsers() {
		return userDAO.getUsers();
	}

	@Override
	public void saveUser(User newUser) {
		userDAO.saveUser(newUser);
	}

	@Override
	public User getUser(int id) {
		return userDAO.getUser(id);
	}

	@Override
	public void deleteUser(int id) {
		userDAO.deleteUser(id);
	}

	@Override
	public Boolean checkUser(String email) {
		return userDAO.checkUser(email);
	}
	
	@Override
	public User validateUser(Integer sid, String email, String pass) {
		User user = userDAO.getUser(email, pass);
		if(user != null) {
			Set<Survey> surveys = user.getSurveys();
			for(Survey survey : surveys) {
				if(survey.getId() == sid) {
					return user;
				}
			}
		}	
		return null;
	}

}
