package com.testproject2.spring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.testproject2.spring.model.Question;
import com.testproject2.spring.model.Survey;
import com.testproject2.spring.services.QuestionService;
import com.testproject2.spring.services.SurveyService;

@Controller
@RequestMapping("question")
public class QuestionsController {

	  @Autowired
	  private QuestionService questionService;
	  
	  @Autowired
	  private SurveyService surveyService;
	  
	  private Map< String, String > types;
	  private Map< String, String > required;
	  
	public QuestionsController() {
		  types = new HashMap<String, String>();
	      types.put("open", "Open question");
	      types.put("single", "Single answer");
	      types.put("multi", "Multiple answers");
	      required = new HashMap<String, String>();
	      required.put("T", "Yes");
	      required.put("F", "No");
	  }
	  
	  @GetMapping("/index")
	  public String list(@RequestParam(value = "sid", required=false) Integer sid, Model model){
		  List<Question> questions = questionService.getQuestions(sid);
		  model.addAttribute("questions", questions);

		  List<Survey> surveys = surveyService.getSurveys();
		  model.addAttribute("surveys", surveys);
		  
		  model.addAttribute("sid", sid);	
		  
		  return "questions/index";  
	  }
	
	  @GetMapping("/create")
	  public String newQuestions(@RequestParam(value = "sid", required=false) Integer sid, Model model){
		  model.addAttribute("question", new Question());
		  model.addAttribute("manageQuestion", "Create");
		  
		  List<Survey> surveys = surveyService.getSurveys();
		  model.addAttribute("surveys", surveys);
		  
	      model.addAttribute("types", types);
	      model.addAttribute("required", required);
	      
	      model.addAttribute("sid", sid);	
		  
		  return "questions/create";
	  }
		 
	  @PostMapping("/save")
	  public String saveQuestion(@RequestParam(value = "question_file", required=false) MultipartFile file, @ModelAttribute("question") Question question){ 
		  questionService.saveQuestion(question, file);	
		  return "redirect:/question/index";
	  }
		 
	  @GetMapping("/update")
	  public String viewQuestion(@RequestParam("id") int id, Model model){
		  Question question = questionService.getQuestion(id);
		  model.addAttribute("question", question);
		  model.addAttribute("manageQuestion", "Update");
		  
		  List<Survey> surveys = surveyService.getSurveys();
		  model.addAttribute("surveys", surveys);	
		  
		  model.addAttribute("types", types);
		  model.addAttribute("required", required); 
		  
		  return "questions/create";
	  }
		 
	  @GetMapping("/delete")
	  public String deleteQuestion(@RequestParam("id") int id, Model model){ 
		  questionService.deleteQuestion(id);
		  return "redirect:/question/index";
	  }
	  
	  @GetMapping("/deletefile")
	  public String deleteFile(@RequestParam("qid") int qid, Model model){ 
		  questionService.deleteQuestionFile(qid, true);
		  
		  model.addAttribute("id", qid);
		  return "redirect:/question/update";
	  } 
}
