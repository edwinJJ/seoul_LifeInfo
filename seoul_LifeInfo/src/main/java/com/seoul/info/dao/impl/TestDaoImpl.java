package com.seoul.info.dao.impl;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.seoul.info.dao.TestDao;
import com.seoul.info.model.TestModel;

@Service
public class TestDaoImpl implements TestDao{

	@Inject
	private SqlSession session;
	private static final String namespace="com.seoul.info.mappers.testMapper";
	
	@Override
	public String setData(TestModel model) throws Exception {
		session.insert(namespace + ".testInsert", model);
		return null;
	}

	@Override
	public String getData() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
