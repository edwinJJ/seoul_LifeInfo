package com.seoul.info.controller;

import java.applet.Applet;
import java.awt.Graphics;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.seoul.info.manager.impl.BoardManagerImpl;
import com.seoul.info.model.BoardModel;


/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController extends Applet {
	
	@Inject
	BoardManagerImpl manager;
	
	@Inject
	BoardModel BoardModel; // Static이 아닌 class 객체를 생성 (생성하는 이유: 자바는 Static인 멤버들이 먼저 컴파일하기 때문에 Static이 아닌 메소드나 필드는 정의되지 않기 때문에 객체를 생성해(생성자) 접근해야 한다. )
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
/*-------------------------------------------------------------------------------------------------------
* 	게시판 메인
* ------------------------------------------------------------------------------------------------------
*/	
	@RequestMapping(value = "/main/board/{number}", method = RequestMethod.GET)
	public ModelAndView navsView(@PathVariable("number") int num) {
			ModelAndView mav = new ModelAndView();
					mav.setViewName("board");
					mav.addObject("ListPageNumber", num);
			return mav;
	}	
	
/*-------------------------------------------------------------------------------------------------------
* 	게시글 작성
* ------------------------------------------------------------------------------------------------------
*/	
	@RequestMapping(value = "/main/board/write", method = RequestMethod.GET)
	public String boardWrite() {
		return "boardWrite";
		
	}	

	
	@RequestMapping(value = "/main/board/write", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String insert(@RequestBody Map<String, String> writeData, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	

		BoardModel.MembersWrite(writeData.get("title"), writeData.get("description"), writeData.get("author"));
		
		
		
    	boolean result = manager.insert(BoardModel);
    	String bool;
    	if(result){bool = "true";}
    	else{bool = "false";}
    	return bool;
    }
	
	@RequestMapping(value = "/main/board/login", method = RequestMethod.GET)
	public String boardLogin() {
		return "boardLogin";
		
	}	
/*-------------------------------------------------------------------------------------------------------
* 	게시글 수정
* ------------------------------------------------------------------------------------------------------
*/	
	
	@RequestMapping(value = "/main/board/updateArticle", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String updateArticle(@RequestBody Map<String, Object> updateData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
    	boolean result = manager.updateArticle(updateData);
    	String bool;
    	if(result){bool = "true";}
    	else{bool = "false";}
    	return bool;
    }
		

	
	
/*-------------------------------------------------------------------------------------------------------
* 	게시판 리스트 개수 가져오기 
* ------------------------------------------------------------------------------------------------------
*/	
	@RequestMapping(value = "/checkLists", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody int checkLists(@RequestBody Map<String, String> logData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		int checkedLists = manager.checkLists();
		return checkedLists;
    }
	
	
	
	
	
/*-------------------------------------------------------------------------------------------------------
* 	게시판 리스트 가져오기 
* ------------------------------------------------------------------------------------------------------
*/	
	@RequestMapping(value = "/getLists", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody Map getLists(@RequestBody Map<String, Integer> boardData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<Object, Object> Lists = manager.getLists(boardData);
		return Lists;
    }
	
	
/*-------------------------------------------------------------------------------------------------------
* 	게시글 가져오기 
* ------------------------------------------------------------------------------------------------------
*/	
		@RequestMapping(value = "/main/board/article/{number}", method = RequestMethod.GET)
		public ModelAndView article(@PathVariable("number") int num) {
				ModelAndView mav = new ModelAndView();
						mav.setViewName("boardArticle");
						mav.addObject("articleNumber", num);
				return mav;
		}		
	
		
		@RequestMapping(value = "/getArticle", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
	    public @ResponseBody Map getArticle(@RequestBody Map<String, Integer> articleNumber, HttpServletRequest request, HttpServletResponse response) throws Exception {
			Map<String, Object> article = manager.getArticle(articleNumber);
			return article;
	    }
		
		@RequestMapping(value = "/getArticleForUpdate", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
	    public @ResponseBody Map getArticleForUpdate(@RequestBody Map<String, Integer> articleNumber, HttpServletRequest request, HttpServletResponse response) throws Exception {
			Map<String, Object> article = manager.getArticleForUpdate(articleNumber);
			return article;
	    }
		
	
		
		
		
	/*-------------------------------------------------------------------------------------------------------
	* 	좋아요 저장 
	* ------------------------------------------------------------------------------------------------------
	*/	
			@RequestMapping(value = "/likeUpdate", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
		    public @ResponseBody String likeUpdate(@RequestBody Map<String, Object> likeData, HttpServletRequest request, HttpServletResponse response) throws Exception {
		    	
		    	boolean result = manager.likeUpdate(likeData);
		    	String bool;
		    	if(result){bool = "true";}
		    	else{bool = "false";}
		    	return bool;
		    }
			
	/*-------------------------------------------------------------------------------------------------------
	* 	좋아요 취소 
	* ------------------------------------------------------------------------------------------------------
	*/	
					@RequestMapping(value = "/likeCancel", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
				    public @ResponseBody String likeCancel(@RequestBody Map<String, Object> likeData, HttpServletRequest request, HttpServletResponse response) throws Exception {
				    	
				    	boolean result = manager.likeCancel(likeData);
				    	String bool;
				    	if(result){bool = "true";}
				    	else{bool = "false";}
				    	return bool;
				    }
					
				
					
	/*-------------------------------------------------------------------------------------------------------
	* 	댓글 저장
	* ------------------------------------------------------------------------------------------------------
	*/	
					@RequestMapping(value = "/setReply", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
					public @ResponseBody String setReply(@RequestBody Map<String, Object> replyData, HttpServletRequest request, HttpServletResponse response) throws Exception {
						    	
						    	boolean result = manager.setReply(replyData);
						    	String bool;
						    	if(result){bool = "true";}
						    	else{bool = "false";}
						    	return bool;
						    }				
	/*-------------------------------------------------------------------------------------------------------
	* 	댓글 가져오기 
	* ------------------------------------------------------------------------------------------------------
	*/	
							
					@RequestMapping(value = "/getReplies", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
				    public @ResponseBody Map getReplies(@RequestBody Map<String, Integer> articleNumber, HttpServletRequest request, HttpServletResponse response) throws Exception {
						Map<Integer, Object> replies = manager.getReplies(articleNumber);
						return replies;
				    }		
	/*-------------------------------------------------------------------------------------------------------
	* 	댓글의 댓글 저장 
	* ------------------------------------------------------------------------------------------------------
	*/	
					@RequestMapping(value = "/setReplyToReply", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
					public @ResponseBody String setReplyToReply(@RequestBody Map<String, Object> replyInReplyData, HttpServletRequest request, HttpServletResponse response) throws Exception {
						    	
						    	boolean result = manager.setReplyToReply(replyInReplyData);
						    	String bool;
						    	if(result){bool = "true";}
						    	else{bool = "false";}
						    	return bool;
						    }	
	/*-------------------------------------------------------------------------------------------------------
     * 게시글 삭제
     * ------------------------------------------------------------------------------------------------------
     */	
				@RequestMapping(value = "/deleteArticle", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
				public @ResponseBody String deleteArticle(@RequestBody Map<String, Object> articleNumber, HttpServletRequest request, HttpServletResponse response) throws Exception {
					    	
					    	boolean result = manager.deleteArticle(articleNumber);
					    	String bool;
					    	if(result){bool = "true";}
					    	else{bool = "false";}
					    	return bool;
					    }						

	/*-------------------------------------------------------------------------------------------------------
     * 댓글 삭제
     * ------------------------------------------------------------------------------------------------------
     */	
				@RequestMapping(value = "/deleteReply", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
				public @ResponseBody String deleteReply(@RequestBody Map<String, Object> replyNumber, HttpServletRequest request, HttpServletResponse response) throws Exception {
					    	
					    	boolean result = manager.deleteReply(replyNumber);
					    	String bool;
					    	if(result){bool = "true";}
					    	else{bool = "false";}
					    	return bool;
					    }				


	/*-------------------------------------------------------------------------------------------------------
     * 	게시판 메인
    * ------------------------------------------------------------------------------------------------------
    */	 
			@RequestMapping(value = "/main/board/updateArticle/{number}", method = RequestMethod.GET)
			public ModelAndView updateArticleView(@PathVariable("number") int num) {
					ModelAndView mav = new ModelAndView();
							mav.setViewName("updateArticle");
							mav.addObject("articleNumber", num);
					return mav;
			}					
}

