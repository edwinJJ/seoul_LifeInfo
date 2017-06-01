package com.seoul.info.manager;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.seoul.info.model.LoginModel;

@Service
public interface LoginManager {
	
	public String setData(String data) throws Exception;
	
	public String getData() throws Exception;
	
	public String setJoin(LoginModel joinData) throws Exception;
	
	public String setLog(Map<String, String> logData) throws Exception;
	
	public String getLog(String name) throws Exception;
	
	
}
