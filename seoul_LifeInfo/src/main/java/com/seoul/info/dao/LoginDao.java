package com.seoul.info.dao;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.seoul.info.model.LoginModel;

@Service
public interface LoginDao {

	public String setData(LoginModel model) throws Exception;
	
	public String getData() throws Exception;
	
	public String setJoin(LoginModel joinData) throws Exception;
}
