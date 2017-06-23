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
	public Map getArticleForUpdate(Map<String, Integer> articleNumber) throws Exception {

		Map article = dao.getArticleForUpdate(articleNumber);
		return article;
	}
	
	
	@Override
	public boolean likeUpdate(Map<String, Object> likeData) throws Exception {

		boolean result = dao.likeUpdate(likeData);
		return result;
	}
	
	
	
	@Override
	public boolean likeCancel(Map<String, Object> likeData) throws Exception {

		boolean result = dao.likeCancel(likeData);
		return result;
	}
	
	@Override
	public boolean setReply(Map<String, Object> replyData) throws Exception {

		boolean result = dao.setReply(replyData);
		return result;
	}
	
	@Override
	public Map getReplies(Map<String, Integer> articleNumber) throws Exception {

		Map replies = dao.getReplies(articleNumber);
		return replies;
	}

	@Override
	public boolean setReplyToReply(Map<String, Object> replyInReplyData) throws Exception {

		boolean result = dao.setReplyToReply(replyInReplyData);
		return result;
	}
	
	
	@Override
	public boolean deleteArticle(Map<String, Object> articleNumber) throws Exception {

		boolean result = dao.deleteArticle(articleNumber);
		return result;
	}
	
	@Override
	public boolean deleteReply(Map<String, Object> replyNumber) throws Exception {

		boolean result = dao.deleteReply(replyNumber);
		return result;
	}
	
	@Override
	public boolean updateArticle(Map<String, Object> updateData) throws Exception {

		boolean result = dao.updateArticle(updateData);
		return result;
	}
	
	
	@Override
	public Map search(Map<String, String> searchData) throws Exception {

		Map Lists = dao.search(searchData);
		return Lists;
	}
	
	
	
	
}
