package com.seoul.info.dao.impl;

import java.awt.List;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;
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
		ArrayList NumberOfLikes = new ArrayList();
		ArrayList articleList = new ArrayList();
		Map<String, Integer> mapp = new HashMap<String, Integer>();
		Map<Integer, Object> map = new HashMap<Integer, Object>();
		mapp.put("offset", Num);
		
		if(Num<0){
			
			mapp.put("offset", 0);
			mapp.put("keyForLastPage", 5 + Num);
			articleList = (ArrayList)session.selectList(namespace + ".boardSelect", mapp);
			NumberOfLikes = (ArrayList) session.selectList(namespace + ".boardNumberOfLikesSelect", mapp);
			for(int i=0 ; i<articleList.size() ; i++){
				if((Map<String, Object>)NumberOfLikes.get(i) != null){
				int NumOfLikes = (Integer) (((Map<String, Object>)NumberOfLikes.get(i)).get("array_upper"));
					((Map<String,Object>) articleList.get(i)).put("likes", NumOfLikes);
				}
				map.put(i+1, (Map<String,Object>) articleList.get(i));
			}
			
			
			
		}else{
				mapp.put("keyForLastPage", 5 );
				articleList = (ArrayList)session.selectList(namespace + ".boardSelect", mapp);
				NumberOfLikes = (ArrayList) session.selectList(namespace + ".boardNumberOfLikesSelect", mapp);
				for(int i=0 ; i<articleList.size() ; i++){
					if((Map<String, Object>)NumberOfLikes.get(i) != null){
					int NumOfLikes = (Integer) (((Map<String, Object>)NumberOfLikes.get(i)).get("array_upper"));
						((Map<String,Object>) articleList.get(i)).put("likes", NumOfLikes);
					}
					map.put(Num+i+1, (Map<String,Object>) articleList.get(i));
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
			
			Map<String, Object> map = new HashMap<String, Object>();
			Map<String, Integer> mapp = new HashMap<String, Integer>();
			Map<String, Object> Likes = new HashMap<String, Object>();
			Map<String, Integer> NumberOfLikes = new HashMap<String, Integer>();
			mapp.put("number", articleNum);
			
			map = session.selectOne(namespace + ".boardArticleSelect", mapp);
			NumberOfLikes = session.selectOne(namespace + ".boardArticleNumberOfLikesSelect", mapp);
			if(NumberOfLikes != null){
				int NumOfLikes = NumberOfLikes.get("array_upper");
				
				String[] likes = new String[NumOfLikes];
				
				for(int i=1; i<=NumOfLikes; i++){
					mapp.put("likesNumber", i);
					Likes = session.selectOne(namespace + ".boardArticleLikesSelect", mapp);
					int I = i-1;
					 likes[I] = (String)Likes.get("likes");
					System.out.println(likes[I]); 
				}
				
				map.put("likes", likes);
			}
			return map;
	}
	
	public Map getArticleForUpdate(Map<String, Integer> articleNumber) throws Exception {
		
		
		int articleNum = articleNumber.get("articleNumber");
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Integer> mapp = new HashMap<String, Integer>();
		mapp.put("number", articleNum);
		
		map = session.selectOne(namespace + ".boardArticleSelectForUpdate", mapp);
		
		return map;
}
	
	


	public boolean likeUpdate(Map<String, Object> likeData) throws Exception {
		int i = (Integer)likeData.get("articleNum");
		String name = (String)likeData.get("name");
		
		Map<String, Integer> NumberOfLikes = new HashMap<String, Integer>();
		
		Map<String, Object> finalLikeData = new HashMap<String, Object>();
		
		finalLikeData.put("number", i);
		finalLikeData.put("name", name);
		
		NumberOfLikes = session.selectOne(namespace + ".boardArticleNumberOfLikesSelect", finalLikeData);
		boolean result = false;
		if(NumberOfLikes != null){
					int NumberOfNewLike = NumberOfLikes.get("array_upper") + 1;
				
				finalLikeData.put("like", NumberOfNewLike);
				
				try {
					session.update(namespace + ".boardLikeUpdate", finalLikeData);
					result = true;
				} catch(Exception e) {
					e.printStackTrace();
				}
		}else{
				try {
					session.update(namespace + ".boardFirstLikeUpdate", finalLikeData);
					result = true;
				} catch(Exception e) {
					e.printStackTrace();
				}
		}
		return result;
	}
	
	public boolean likeCancel(Map<String, Object> likeData) throws Exception {
		int i = (Integer)likeData.get("articleNum");
		String name = (String)likeData.get("name");
		
		Map<String, Object> finalLikeData = new HashMap<String, Object>();
		
		finalLikeData.put("number", i);
		finalLikeData.put("name", name);
		
		boolean result = false;
		
					try {
						session.update(namespace + ".boardLikeCancelUpdate", finalLikeData);
						result = true;
					} catch(Exception e) {
						e.printStackTrace();
					}
		
		return result;
	}
	
	public boolean setReply(Map<String, Object> replyData) throws Exception {
		int i = (Integer)replyData.get("articleNum");
		String name = (String)replyData.get("name");
		String replyDesc = (String)replyData.get("replyDesc");
		
		Map<String, Object> finalReplyData = new HashMap<String, Object>();
		
		finalReplyData.put("number", i);
		finalReplyData.put("name", name);
		finalReplyData.put("reply", replyDesc);
		
		boolean result = false;
		try {
			session.insert(namespace + ".boardReplyInsert", finalReplyData);
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
				
		return result;
	}
	
	public Map getReplies(Map<String, Integer> articleNumber) throws Exception {
		
		
		//location[1] == articleNumber 인 댓글의 number, name, description 가져오기 -->> final 맵에 추가
		
		//location[1] == articleNumber 인 댓글의 location을 자바 배열의 형태로 바꿔서 -->> final 맵에 추가 
		
		//location 배열 그냥 사용할 수 있는지 테스트
		
		/*
		 finalMap = {1={number=1, name=byungjunjung, description=~~~, location=[I@274d0904]}, 
						2={number=2, name=byungjunjung, description=~~~, location=[I@274d0904]},
						 	3={number=4, name=byungjunjung, description=~~~, location=[I@274d0904]}
					}
					
		*/
		
		
		Map<Integer, Object> finalMap = new HashMap<Integer, Object>();
		
		
//mapper에 전달할 map인 mapp 선언 		
		Map<Object, Object> mapp = new HashMap<Object, Object>();
		mapp.put("number", articleNumber.get("articleNumber"));
		
		
//location[1] = articlenumber인 댓글들의 number 가져오기  -----------------------------------------------------------------------------------------------------
		ArrayList RightReplyNumberList = new ArrayList();
		RightReplyNumberList = (ArrayList) session.selectList(namespace + ".boardRightReplyNumberSelect", mapp); //[{number=1}, {number=2}, {number=3}]
//----------------------------------------------------------------------------------------------------- -----------------------------------------------------------------------------------------------------		
		
		
		for(int i=0; i<RightReplyNumberList.size() ; i++){
					int RightReplyNumber = ((Map<String,Integer>) RightReplyNumberList.get(i)).get("number");
					mapp.put("replyNum", RightReplyNumber);
					
			//location의 길이 가져오기  -----------------------------------------------------------------------------------------------------	
					HashMap NumberOfLocationMap = session.selectOne(namespace + ".boardReplyNumberOfLocationSelect", mapp);
					int NumberOfLocation = (Integer) NumberOfLocationMap.get("array_upper");
			//----------------------------------------------------------------------------------------------------	
					
					int[] InstanceArray = new int[NumberOfLocation];
					for(int l=0; l<NumberOfLocation; l++){
								mapp.put("l", l+1);
								Map<String, Object> OneReplyLocation = new HashMap<String, Object>();
								OneReplyLocation = session.selectOne(namespace + ".boardReplyRightLocationSelect", mapp);
								InstanceArray[l] = (Integer) OneReplyLocation.get("location");
					}
					
					Map<String, Object> replyMap = new HashMap<String, Object>();
					replyMap = session.selectOne(namespace + ".boardReplySelect", mapp);
					replyMap.put("location", InstanceArray);
					finalMap.put(i+1, replyMap);
			
		}
	
		System.out.println(finalMap);
//postgresql 배열을 java 배열로 변경 -----------------------------------------------------------------------------------------------------
		/*
		int[] testArray = new int[1];
		
		for(int i=0; i<1; i++){
			sendData.put("i", i+1);
			FirstReplyLocation = session.selectOne(namespace + ".boardOneLocationSelect", sendData);
			testArray[i] = (Integer) FirstReplyLocation.get("location");
		}
		*/
//--------------------------------------------------------------------------------------------------------------------------------------		
		
		
		return finalMap;
		
	}
	
	
	public boolean setReplyToReply(Map<String, Object> replyInReplyData) throws Exception {
		String name = (String)replyInReplyData.get("name");
		String replyInReplyDesc = (String)replyInReplyData.get("replyInReplyDesc");
		int replyNum = (Integer)replyInReplyData.get("replyNum");
		
		Map<Object, Object> mapp = new HashMap<Object, Object>();
		mapp.put("replyNum", replyNum);
		mapp.put("userName", name);
		mapp.put("reply", replyInReplyDesc);
		
		
		HashMap NumberOfLocationMap = session.selectOne(namespace + ".boardReplyNumberOfLocationSelect", mapp);
		int NumberOfLocation = (Integer) NumberOfLocationMap.get("array_upper");
		
		int[] SuperLocationArray = new int[NumberOfLocation];
		for(int i=0; i<NumberOfLocation; i++){
			mapp.put("i", i+1);
			HashMap FirstReplyLocation = session.selectOne(namespace + ".superReplyLocationSelect", mapp);
			SuperLocationArray[i] = (Integer) FirstReplyLocation.get("location");
		}
		
		int[] ThisLocationArray = new int[SuperLocationArray.length + 1];
		System.arraycopy(SuperLocationArray, 0, ThisLocationArray, 0, SuperLocationArray.length);
		ThisLocationArray[SuperLocationArray.length] = replyNum;
		
		System.out.println(ThisLocationArray);
		
		String LocationString = "{";
		for(int i=0 ; i<ThisLocationArray.length ; i++){
			if(i == ThisLocationArray.length -1){LocationString += ThisLocationArray[i];}
			else{LocationString += ThisLocationArray[i] + "," + "";}
		}
		LocationString += "}";
		mapp.put("newLocation", LocationString);
		
		
		boolean result = false;
		try {
			session.insert(namespace + ".boardReplyToReplyInsert", mapp);
			result = true;
		} catch(Exception e) {
			e.printStackTrace();
		}
			
		return result;
	}
	
	
	public boolean deleteArticle(Map<String, Object> articleNumber) throws Exception {
		int i = (Integer)articleNumber.get("articleNumber");
		
		Map<String, Object> mapp = new HashMap<String, Object>();
		
		mapp.put("number", i);
		
		boolean result = false;
		
		try {
			    session.delete(namespace + ".boardArticleDelete", mapp);
			    session.delete(namespace + ".boardArticleReplyDelete", mapp);
				result = true;
			}catch(Exception e) {
					e.printStackTrace();
			}
		
		return result;
	}
	
	
	public boolean deleteReply(Map<String, Object> replyNumber) throws Exception {
		int i = (Integer)replyNumber.get("replyNumber");
		
		Map<String, Object> mapp = new HashMap<String, Object>();
		
		mapp.put("number", i);
		
		boolean result = false;
		
		try {
			    session.delete(namespace + ".boardReplyDelete", mapp);
				result = true;
			}catch(Exception e) {
					e.printStackTrace();
			}
		
		return result;
	}
	
	public boolean updateArticle(Map<String, Object> updateData) throws Exception {
		int i = (Integer)updateData.get("articleNumber");
		String title = (String)updateData.get("title");
		String description = (String)updateData.get("description");
		
		Map<String, Object> mapp = new HashMap<String, Object>();
		
		mapp.put("number", i);
		mapp.put("title", title);
		mapp.put("description", description);
		
		boolean result = false;
		
					try {
						session.update(namespace + ".boardArticleUpdate", mapp);
						result = true;
					} catch(Exception e) {
						e.printStackTrace();
					}
		
		return result;
	}
}