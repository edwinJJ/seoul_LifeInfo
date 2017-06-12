package com.seoul.info.dao;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.seoul.info.model.BoardModel;

@Service
public interface BoardDao {
	public boolean insert(BoardModel writeData) throws Exception;
	public Map getLists(Map<String, Integer> boardData) throws Exception;
	public int checkLists() throws Exception;
	public Map getArticle(Map<String, Integer> articleNumber) throws Exception;
	public boolean likeUpdate(Map<String, Object> likeData) throws Exception;
}
