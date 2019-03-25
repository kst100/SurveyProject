package com.testproject2.spring.controller;

import java.util.List;
import java.util.ListIterator;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.testproject2.spring.model.Question;
import com.testproject2.spring.model.QuestionsListWrapper;
import com.testproject2.spring.model.Survey;
import com.testproject2.spring.model.SurveyDataWrapper;
import com.testproject2.spring.model.User;
import com.testproject2.spring.services.AnswerService;
import com.testproject2.spring.services.QuestionService;
import com.testproject2.spring.services.SurveyAnswersService;
import com.testproject2.spring.services.SurveyService;
import com.testproject2.spring.services.UserService;

@Controller
@RequestMapping("front")
@SessionAttributes("answerFrm")
public class FrontController {
	
	  private boolean logged = false;
	  private SurveyDataWrapper surveyData;
	  private QuestionsListWrapper node = null;
	  private ListIterator<QuestionsListWrapper> listIterator = null;
	  private boolean isFirst = false;
	  private boolean isLast = false;
	  private String direction;
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
	  public String index(@RequestParam("sid") int sid, HttpSession httpSession, Model model){ 
		  model.addAttribute("sid", sid);
		  if(this.isLogged()) {
			  model.addAttribute("surveyData", surveyData);
			  model.addAttribute("server_path", server_path);
			  
			  // Always load the first node if user is on index page. Reset list iterator
			  listIterator = surveyData.getQuestionsList().listIterator();
			  
			  node = (QuestionsListWrapper) listIterator.next();
			  model.addAttribute("node", node);

			  isFirst = true;
			  model.addAttribute("isFirst", isFirst);
			  
			  isLast = !listIterator.hasNext();
			  model.addAttribute("isLast", isLast);
			  
			  direction = "frw";
			  model.addAttribute("direction", direction);

			  //Set up session data
			  String key = "survey_id";
			  httpSession.setAttribute(key, sid);

			  key = "survey_expiration";
			  httpSession.setAttribute(key, surveyData.getSurvey().getExpirationDate());
			  
			  key = "user_id";
			  httpSession.setAttribute(key, surveyData.getUser().getId());

			  return "front/index";
		  } else {
			  return "redirect:/front/login";
		  }
	  }		  

	  @PostMapping("/next") 
	  public String next(@RequestParam("dir") String dir, @RequestParam MultiValueMap<String, String> queryMap, Model model, HttpSession httpSession){ 
		  if(this.isLogged()) {
			  model.addAttribute("surveyData", surveyData);
			  
			  Set<String> keys = queryMap.keySet();
			  for (String key : keys) {
				  httpSession.setAttribute(key, queryMap.get(key));
			  } 			  
			  
			  node = (QuestionsListWrapper) listIterator.next();
			  
			  if(!direction.equals(dir)) {
				  node = (QuestionsListWrapper) listIterator.next();
				  direction = "frw";
			  }
			  model.addAttribute("node", node);

			  isFirst = !listIterator.hasPrevious();
			  model.addAttribute("isFirst", isFirst);
			  
			  isLast = !listIterator.hasNext();
			  model.addAttribute("isLast", isLast);
			  
			  model.addAttribute("direction", direction);
			  
			  return "front/index";
		  } else {
			  return "redirect:/front/login";
		  }
	  }
	  
	  @GetMapping("/prev")
	  public String prev(@RequestParam("dir") String dir, Model model){ 
		  if(this.isLogged()) {
			  model.addAttribute("surveyData", surveyData);
			  
			  node = (QuestionsListWrapper) listIterator.previous();
			  
			  if(!direction.equals(dir)) {
				  node = (QuestionsListWrapper) listIterator.previous();
				  direction = "bck";
			  }			  
			  model.addAttribute("node", node);

			  isFirst = !listIterator.hasPrevious();
			  model.addAttribute("isFirst", isFirst);
			  
			  isLast = !listIterator.hasNext();
			  model.addAttribute("isLast", isLast);
			  
			  model.addAttribute("direction", direction);
			  
			  return "front/index";
		  } else {
			  return "redirect:/front/login";
		  }
	  }		
	  
	  @PostMapping("/save")
	  public String save(@RequestParam MultiValueMap<String, String> queryMap, Model model, HttpSession httpSession){
		  
		  // Add the last answer
		  Set<String> keys = queryMap.keySet();
		  for (String key : keys) {
			  httpSession.setAttribute(key, queryMap.get(key));
		  } 		  
		  
		  surveyAnswersService.saveSurveyAnswer(httpSession);
		  httpSession.invalidate();
		  
		  return "front/thankyou";
	  }	  
	  
	  @GetMapping("/preview")
	  public String previewSurvey(@RequestParam("sid") int sid, Model model){
		  model.addAttribute("sid", sid);
		  if(this.isLogged()) { 
			  return "redirect:/front/index";
		  }	 
		  return "redirect:/front/login"; 
	  }	
	  
	  @PostMapping("/doLogin")
	  public String doLogin(@RequestParam("sid") int sid, @RequestParam("email")String email, @RequestParam("pass")String pass, Model model){
		  model.addAttribute("sid", sid);
		  User user = userService.validateUser(sid, email, pass);
		  
		  boolean logged = false;
		  if(user != null) logged = true;
		  
		  this.setLogged(logged); 
		  if(logged) {
			  surveyData = new SurveyDataWrapper();
			  surveyData.setUser(user);
			  Survey survey = surveyService.getSurvey(sid);
			  surveyData.setSurvey(survey);
			  questions = questionService.getQuestions(sid);
			  surveyData.setQuestions(questions, answerService);
			  listIterator = surveyData.getQuestionsList().listIterator();
			  
			  return "redirect:/front/index";
		  }	 
		  
		  return "redirect:/front/login?err=E1";
	  }		  
	  
	  @GetMapping("/login")
	  public String showLogin(@RequestParam("sid") int sid, Model model){ 
		  model.addAttribute("sid", sid);
		  return "front/login";
	  }	
	  
	  public boolean isLogged() {
		  return logged;
	  }

	  public void setLogged(boolean logged) {
		  this.logged = logged;
	  }
}
