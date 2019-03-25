package com.testproject2.spring.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class AnswersListWrapper {
	
	private List<Answer> answers;
	private List<MultipartFile> files;
	
	public List<Answer> getAnswers() {
	    return answers;
	}

	public void setAnswers(List<Answer> answers) {
	    this.answers = answers;
	}

	public List<MultipartFile> getFiles() {
		return files;
	}

	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}	
}
