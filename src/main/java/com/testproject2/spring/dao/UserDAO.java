package com.testproject2.spring.dao;

import java.util.List;
import com.testproject2.spring.model.User;

public interface UserDAO {

	 public List<User> getUsers();
	 public void saveUser(User newUser);
	 public User getUser(int id);
	 public User getUser(String email, String pass);
	 public void deleteUser(int id);
	 public Boolean checkUser(String email);	
}
