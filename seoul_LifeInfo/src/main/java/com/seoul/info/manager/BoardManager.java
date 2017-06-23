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
	
	public boolean likeCancel(Map<String, Object> likeData) throws Exception; 
	
	public boolean setReply(Map<String, Object> replyData) throws Exception;
	
	public Map getReplies(Map<String, Integer> articleNumber) throws Exception;
	
	public boolean setReplyToReply(Map<String, Object> replyInReplyData) throws Exception;
	
	public boolean deleteArticle(Map<String, Object> articleNumber) throws Exception;
	
	public boolean deleteReply(Map<String, Object> replyNumber) throws Exception;
	
	public Map getArticleForUpdate(Map<String, Integer> articleNumber) throws Exception;
	
	public boolean updateArticle(Map<String, Object> updateData) throws Exception;

	Map search(Map<String, String> searchData) throws Exception;

}
