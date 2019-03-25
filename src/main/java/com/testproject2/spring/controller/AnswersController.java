package com.testproject2.spring.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.testproject2.spring.model.Answer;
import com.testproject2.spring.model.AnswersListWrapper;
import com.testproject2.spring.model.Question;
import com.testproject2.spring.services.AnswerService;
import com.testproject2.spring.services.QuestionService;

@Controller
@RequestMapping("answers")
public class AnswersController {

	  @Autowired
	  private QuestionService questionService;
	  
	  @Autowired
	  private AnswerService answerService;
	  
	  @GetMapping("/index")
	  public String list(@RequestParam Integer sid, @RequestParam Integer qid, Model model){
		  
		  List<Question> questions = questionService.getQuestions(sid);
		  model.addAttribute("questions", questions);

		  AnswersListWrapper wrapper = new AnswersListWrapper();
		  wrapper.setAnswers(new ArrayList<Answer>(answerService.getAnswers(qid)));
		  model.addAttribute("answersListWrapper",wrapper);
		  
		  model.addAttribute("sid", sid);
		  model.addAttribute("qid", qid);	
		  
		  return "answers/index";  
	  }

	  @PostMapping("/save")
	  public String saveAnswer(@RequestParam Integer sid, @RequestParam Integer qid, @RequestParam String delete_answers, @ModelAttribute("answersListWrapper") AnswersListWrapper answersListWrapper, Model model){ 
		  
		  List<Answer> answers = answersListWrapper.getAnswers();
		  List<MultipartFile> files = answersListWrapper.getFiles();
		  if(null != answers && answers.size() > 0) {
			  answerService.saveAnswers(answers, qid, delete_answers, files); 
		  }	else {
			  answerService.deleteAnswers(qid);  
		  }
		  model.addAttribute("sid", sid);	
		  model.addAttribute("qid", qid);	 
		  return "redirect:/answers/index";
	  }	

	  @GetMapping("/deletefile")
	  public String deleteFile(@RequestParam Integer sid, @RequestParam Integer qid, @RequestParam("aid") int aid, Model model){ 
		  answerService.deleteAnswerFile(aid, true);
		  
		  model.addAttribute("sid", sid);	
		  model.addAttribute("qid", qid);	
		  return "redirect:/answers/index";
	  }	
}
