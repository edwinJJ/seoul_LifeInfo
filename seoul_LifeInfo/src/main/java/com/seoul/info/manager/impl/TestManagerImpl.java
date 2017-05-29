package com.seoul.info.manager.impl;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoul.info.dao.impl.TestDaoImpl;
import com.seoul.info.manager.TestManager;
import com.seoul.info.model.TestModel;

@Service
public class TestManagerImpl implements TestManager{

	@Inject
	TestModel model;
	
	@Inject
	TestDaoImpl dao;
	
	@Override
	public String setData(String data) throws Exception {
		
		model.setData(data);
		
		dao.setData(model);
		return null;
	}

	@Override
	public String getData() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
