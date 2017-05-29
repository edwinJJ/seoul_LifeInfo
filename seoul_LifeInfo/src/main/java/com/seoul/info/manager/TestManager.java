package com.seoul.info.manager;

import org.springframework.stereotype.Service;

@Service
public interface TestManager {
	
	public String setData(String data) throws Exception;
	
	public String getData() throws Exception;
}
