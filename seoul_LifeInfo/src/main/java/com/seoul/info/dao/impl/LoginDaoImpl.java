package com.seoul.info.dao.impl;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.seoul.info.dao.LoginDao;
import com.seoul.info.manager.impl.LoginManagerImpl;
import com.seoul.info.model.LoginModel;

@Service
public class LoginDaoImpl implements LoginDao{

	@Inject
	private SqlSession session;
	private static final String namespace="com.seoul.info.mappers.userMapper";
	
	@Inject
	LoginManagerImpl manager;
	
	@Override
	public String setData(LoginModel model) throws Exception {
		session.insert(namespace + ".testInsert", model);
		return null;
	}

	@Override
	public String getData() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean setJoin(LoginModel joinData) throws Exception {
		boolean result = false;
		try {
			session.insert(namespace + ".usersInsert", joinData);
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public String setLog(Map<String, String> logData) throws Exception {
		 String id = logData.get("id");
		 String Password = logData.get("password");
		 String name = null;
		 String Pass = session.selectOne(namespace + ".usersCheck", id );

		if(Password.equals(Pass)){
		    name = session.selectOne(namespace + ".usersName", id);
		}else{
		}
		return name;
	}
}
