package com.seoul.info.manager.impl;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.seoul.info.controller.BoardController;
import com.seoul.info.dao.impl.BoardDaoImpl;
import com.seoul.info.manager.BoardManager;
import com.seoul.info.model.BoardModel;

@Service
public class BoardManagerImpl implements BoardManager{

	@Inject
	BoardModel model;
	
	@Inject
	BoardDaoImpl dao;
	
	@Inject
	BoardController controller;
	


	@Override
	public boolean insert(BoardModel writeData) throws Exception {

		boolean result = dao.insert(writeData);
		return result;
	}
	
	@Override
	public Map getLists(Map<String, Integer> boardData) throws Exception {

		Map Lists = dao.getLists(boardData);
		return Lists;
	}
	
	@Override
	public int checkLists() throws Exception {

		int checkedLists = dao.checkLists();
		return checkedLists;
	}
	
	@Override
	public Map getArticle(Map<String, Integer> articleNumber) throws Exception {

		Map article = dao.getArticle(articleNumber);
		return article;
	}
	
	
	@Override
	public boolean likeUpdate(Map<String, Object> likeData) throws Exception {

		boolean result = dao.likeUpdate(likeData);
		return result;
	}
	
	
}
