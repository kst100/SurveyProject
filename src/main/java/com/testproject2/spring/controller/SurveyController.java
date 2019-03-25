package com.testproject2.spring.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.http.HttpStatus;

import com.testproject2.spring.model.Survey; 
import com.testproject2.spring.model.User;
import com.testproject2.spring.services.SurveyService;
import com.testproject2.spring.services.UserService;

import org.apache.commons.logging.LogFactory;

@Controller
@RequestMapping("survey")
public class SurveyController {
	
	  private static Log logger = LogFactory.getLog(SurveyController.class);
	  
	  @Autowired
	  private SurveyService surveyService;

	  @Autowired
	  private UserService userService;
	  
	  @GetMapping("/index")
	  public String list(Model model){
		  List<Survey> surveys = surveyService.getSurveys();
		  model.addAttribute("surveys", surveys);		  
		  return "surveys/index";  
	  }
	 
	  @GetMapping("/create")
	  public String newSurvey(Model model){
		  model.addAttribute("survey", new Survey());
		  model.addAttribute("manageSurvey", "Create");
		  
		  List<User> usersPerSurvey = userService.getUsers();
		  model.addAttribute("usersPerSurvey", usersPerSurvey);		  
		  return "surveys/create";
	  }
	 
	  @PostMapping("/save")
	  // ModelAttribute survey is the object we created in newSurvey
	  public String saveSurvey(@ModelAttribute("survey") Survey survey){
		  
		  Set<User> tmp2 = new HashSet<>(); 
		  Set<User> tmp = survey.getUsersPerSurvey();
			for(User user : tmp ) {
				int user_id = Integer.parseInt(user.getfName());
				tmp2.add(userService.getUser(user_id));
			};		  
			survey.setUsersPerSurvey(tmp2);
			
		  surveyService.saveSurvey(survey);		  
		  return "redirect:/survey/index";
	  }
	 
	  @GetMapping("/update")
	  public String viewSurvey(@RequestParam("id") int id, Model model){
		  Survey survey = surveyService.getSurvey(id);
		  model.addAttribute("survey", survey);
		  model.addAttribute("manageSurvey", "Update");
		  
		  List<User> usersPerSurvey = userService.getUsers();
		  model.addAttribute("usersPerSurvey", usersPerSurvey);		  
		  return "surveys/create";
	  }
	 
	  @GetMapping("/delete")
	  public String deleteSurvey(@RequestParam("id") int id, Model model){ 
		  surveyService.deleteSurvey(id);
		  return "redirect:/survey/index";
	  }
	  
	  /*
	  @InitBinder
	  protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
	      binder.registerCustomEditor(Survey.class, "survey", new PropertyEditorSupport() {
	          @Override
	          public void setAsText(String text) {
	        	  int user_id = Integer.parseInt(text);
	              User user = userService.getUser(user_id); 
	              setValue(user);
	          }
	      });
	  }	  
	  */
	  
	  @ExceptionHandler
	  @ResponseStatus(HttpStatus.BAD_REQUEST)
	  public void handle(Exception e) {
		  logger.debug(e);
	  }
	  
	  /* Sources
	   * http://websystique.com/springmvc/springmvc-hibernate-many-to-many-example-annotation-using-join-table/
	   * 
	  */
}
