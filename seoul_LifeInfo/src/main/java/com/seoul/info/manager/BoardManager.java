package com.seoul.info.manager;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.seoul.info.model.BoardModel;

@Service
public interface BoardManager {
	

	public boolean insert(BoardModel writeData) throws Exception;
	
	public Map getLists(Map<String, Integer> boardData) throws Exception;
	
	public int checkLists() throws Exception;
	
	public Map getArticle(Map<String, Integer> articleNumber) throws Exception;
	
	public boolean likeUpdate(Map<String, Object> likeData) throws Exception;
}
