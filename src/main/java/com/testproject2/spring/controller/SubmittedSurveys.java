package com.testproject2.spring.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.testproject2.spring.model.Question;
import com.testproject2.spring.model.Survey;
import com.testproject2.spring.model.SurveyAnswersDetails;
import com.testproject2.spring.model.SurveyDataWrapper;
import com.testproject2.spring.services.AnswerService;
import com.testproject2.spring.services.QuestionService;
import com.testproject2.spring.services.SurveyAnswersService;
import com.testproject2.spring.services.SurveyService;
import com.testproject2.spring.services.UserService;

@Controller
@RequestMapping("submitted")
public class SubmittedSurveys {

	  private SurveyDataWrapper surveyData;
	  private List<Question> questions = null;
	  
	  @Value("${fileUploadServerPath}")
	  private String server_path;		  
	  
	  @Autowired
	  private SurveyService surveyService;

	  @Autowired
	  private UserService userService;

	  @Autowired
	  private QuestionService questionService;
	  
	  @Autowired
	  private AnswerService answerService;
	  
	  @Autowired
	  private SurveyAnswersService surveyAnswersService;	  
	  
	  @GetMapping("/index")
	  public String list(Model model){ 
		  List<SurveyAnswersDetails> surveyAnswersDetails = surveyAnswersService.getSurveyAnswersDetails();
		  model.addAttribute("surveyAnswersDetails", surveyAnswersDetails);		  
		  return "submitted/index";
	  }
	  
	  @GetMapping("/view")
	  public String view(@RequestParam("said") int said, HttpSession httpSession, Model model){
		  
		  Integer sid = surveyAnswersService.getSurveyAnswer(said).getSurvey_id();
		  
		  surveyData = new SurveyDataWrapper();
		  surveyData.setUser(userService.getUser(surveyAnswersService.getSurveyAnswer(said).getUser_id()));
		  Survey survey = surveyService.getSurvey(sid);
		  surveyData.setSurvey(survey);
		  questions = questionService.getQuestions(sid);
		  surveyData.setQuestions(questions, answerService);
		  
		  model.addAttribute("surveyData", surveyData);
		  model.addAttribute("server_path", server_path);
		  
		  return "submitted/view";
	  }		  
}
