package com.seoul.info.model;

import org.springframework.stereotype.Service;

@Service
public class TestModel {
	private String data;

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
	
}


