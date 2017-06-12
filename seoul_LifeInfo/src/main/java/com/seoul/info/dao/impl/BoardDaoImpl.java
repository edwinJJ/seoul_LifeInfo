package com.seoul.info.dao.impl;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.seoul.info.dao.BoardDao;
import com.seoul.info.manager.impl.BoardManagerImpl;
import com.seoul.info.model.BoardModel;

@Service
public class BoardDaoImpl implements BoardDao{

	@Inject
	private SqlSession session;
	private static final String namespace="com.seoul.info.mappers.boardMapper";
	
	@Inject
	BoardManagerImpl manager;
	

	public boolean insert(BoardModel writeData) throws Exception {
		boolean result = false;
		try {
			session.insert(namespace + ".boardInsert", writeData);
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public Map getLists(Map<String, Integer> boardData) throws Exception {
		
		
		int ListPageNum = boardData.get("ListPageNum");
		int NumLists = boardData.get("NumLists");
		int Num = NumLists-(ListPageNum)*5;
		
		Map<Integer, Object> map = new HashMap<Integer, Object>();

		if(Num<0){
			for(int i=1; i<=NumLists%5; i++){
				Map<String, Integer> mapp = new HashMap<String, Integer>();
				mapp.put("number", i);
				map.put(i, session.selectOne(namespace + ".boardSelect", mapp));
			}
			
		}else{
		
			for(int i=Num+1; i<Num+6; i++){
				Map<String, Integer> mapp = new HashMap<String, Integer>();
				mapp.put("number", i);
				map.put(i, session.selectOne(namespace + ".boardSelect", mapp));
			}
		}
		
		return map;
	}
	
	public int checkLists() throws Exception {
		int checkedLists;
		checkedLists = session.selectOne(namespace + ".boardCheck");
		
		return checkedLists;
	}
	
	
public Map getArticle(Map<String, Integer> articleNumber) throws Exception {
		
		
		int articleNum = articleNumber.get("articleNumber");
		
		Map<String, String> map = new HashMap<String, String>();
		Map<String, Integer> mapp = new HashMap<String, Integer>();
		mapp.put("number", articleNum);
		map = session.selectOne(namespace + ".boardArticleSelect", mapp);
		
		return map;
	}
	
	


public boolean likeUpdate(Map<String, Object> likeData) throws Exception {
	int i = (Integer)likeData.get("articleNum");
	String name = (String)likeData.get("name");
	Map<String, Object> finalLikeData = new HashMap<String, Object>();
	finalLikeData.put("articleNum", i);
	finalLikeData.put("name", name);
	
	
	boolean result = false;
	try {
		session.update(namespace + ".boardLikeUpdate", finalLikeData);//syntax error at or near "$1"  -->the value provided must be a constant, not a parameter.?????????
		result = true;
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	return result;
}
	
}