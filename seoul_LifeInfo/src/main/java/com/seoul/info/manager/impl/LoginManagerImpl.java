package com.seoul.info.manager.impl;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoul.info.controller.LoginController;
import com.seoul.info.dao.impl.LoginDaoImpl;
import com.seoul.info.manager.LoginManager;
import com.seoul.info.model.LoginModel;

@Service
public class LoginManagerImpl implements LoginManager{

	@Inject
	LoginModel model;
	
	@Inject
	LoginDaoImpl dao;
	
	@Inject
	LoginController controller;
	
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

	@Override
	public boolean setJoin(LoginModel joinData) throws Exception {

		boolean result = dao.setJoin(joinData);
		return result;
	}
	
	
	@Override
	public String setLog(Map<String, String> logData) throws Exception {

		String name = dao.setLog(logData); //name
		return name;
	}
	
	@Override
	public String getLog(String name) throws Exception {

		
		return null;
	}
	
	
	
}
