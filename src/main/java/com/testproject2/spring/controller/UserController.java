package com.testproject2.spring.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.testproject2.spring.model.User;
import com.testproject2.spring.services.UserService;

@Controller
@RequestMapping("user")
public class UserController {
	
	  @Autowired
	  private UserService userService;
	 
	  @GetMapping("/index")
	  public String list(Model model){
		  List<User> users = userService.getUsers();
		  model.addAttribute("users", users);		  
		  return "users/index";  
	  }
	 
	  @GetMapping("/create")
	  public String newUser(Model model){
		  model.addAttribute("user", new User());
		  model.addAttribute("manageUser", "Create");
		  return "users/create";
	  }
	 
	  @PostMapping("/save")
	  public String saveUser(@ModelAttribute("user") User user){
		  userService.saveUser(user);		  
		  return "redirect:/user/index";
	  }
	 
	  @GetMapping("/update")
	  public String viewUser(@RequestParam("id") int id, Model model){
		  User user = userService.getUser(id);
		  model.addAttribute("user", user);
		  model.addAttribute("manageUser", "Update");
		  return "users/create";
	  }
	 
	  @GetMapping("/delete")
	  public String deleteUser(@RequestParam("id") int id, Model model){ 
		  userService.deleteUser(id);
		  return "redirect:/user/index";
	  } 
	  
	  @GetMapping("/checkemail")
	  public @ResponseBody
	  String checkUser(@RequestParam("email") String email, Model model){
		  Boolean found = userService.checkUser(email); 
		  if(!found) return "200";
		  else return "100";
	  }	  
}