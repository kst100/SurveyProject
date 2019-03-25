package com.testproject2.spring.services;

import java.util.List;

import com.testproject2.spring.model.User;

public interface UserService {
	 public List<User> getUsers();
	 public void saveUser(User newUser);
	 public User getUser(int id);
	 public void deleteUser(int id);
	 public Boolean checkUser(String email);	
	 public User validateUser(Integer sid, String email, String pass);
}
