package com.testproject2.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.testproject2.spring.model.Question;
import com.testproject2.spring.model.Survey;
import com.testproject2.spring.services.QuestionService;
import com.testproject2.spring.services.QuestionServiceImpl.QuestionsReport;
import com.testproject2.spring.services.SurveyService;

@Controller
@RequestMapping("report")
public class ReportsController {
	
	  @Autowired
	  private SurveyService surveyService;
	  
	  @Autowired
	  private QuestionService questionService;
	  
	  @GetMapping("/index")
	  public String list(@RequestParam(value = "sid", required=false) Integer sid, Model model){
		  
		  List<Survey> surveys = surveyService.getSurveys();
		  model.addAttribute("surveys", surveys);

		  if(sid == null) {
			  sid = surveys.get(0).getId();
		  }
		  
		  List<Question> questions = questionService.getQuestions(sid);
		  model.addAttribute("questions", questions);
		  
		  Integer answersCount = questionService.getAnswersCount(sid); 
		  model.addAttribute("answersCount", answersCount);
		  
		  List<QuestionsReport> questionsReport = new ArrayList<QuestionsReport>();
		  for(Question question : questions) {
			  questionsReport.addAll(questionService.getAnswersReport(question.getId()));
		  }
		  model.addAttribute("questionsReport", questionsReport);
		  model.addAttribute("sid", sid);	
		  return "reports/index";
	  }	  
}
