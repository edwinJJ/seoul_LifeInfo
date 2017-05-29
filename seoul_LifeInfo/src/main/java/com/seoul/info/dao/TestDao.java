package com.seoul.info.dao;

import org.springframework.stereotype.Service;

import com.seoul.info.model.TestModel;

@Service
public interface TestDao {

	public String setData(TestModel model) throws Exception;
	
	public String getData() throws Exception;
}
