package com.seoul.info.model;

import org.springframework.stereotype.Service;

@Service
public class BoardModel {
	private int number;
	private String author;
	private String description;
	private String title;

	public void MembersWrite(String title, String description, String author) {

		this.author = author;

		this.description = description;

		this.title = title;
	}
	
	
	
	public void GetNumber(int number){
		this.number = number;
	}
}