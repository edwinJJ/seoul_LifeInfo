package com.seoul.info.controller;

import java.applet.Applet;
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

import com.seoul.info.manager.impl.LoginManagerImpl;
import com.seoul.info.model.LoginModel;

/**
 * Handles requests for the application home page.
 */


@Controller
public class LoginController extends Applet {
	
	@Inject
	LoginManagerImpl manager;
	
	@Inject
	LoginModel loginModel;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	
/*-------------------------------------------------------------------------------------------------------
* 	MAIN PAGE
* ------------------------------------------------------------------------------------------------------
*/		
		@RequestMapping(value = "/", method = RequestMethod.GET)
		public ModelAndView home() {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("main");
			mav.addObject("ListPageNumber", 1);
			return mav;
		}	
	
	
		@RequestMapping(value = "/{number}", method = RequestMethod.GET)
		public ModelAndView homeNumber(@PathVariable("number") int num) {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("main");
			mav.addObject("ListPageNumber", num);
			return mav;
		}	
		
		@RequestMapping(value = "/main/{nav}", method = RequestMethod.GET)
		public String navsView(@PathVariable("nav") String nav) {
			
			return nav;
			
		}	
		
		
/*-------------------------------------------------------------------------------------------------------
 * 	JOIN PAGE
 * ------------------------------------------------------------------------------------------------------
 */
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		return "join";
	}
	
	@RequestMapping(value = "/join", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String join(@RequestBody Map<String, String> joinData, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	loginModel.setId(joinData.get("id"));
    	loginModel.setPassword(joinData.get("password"));
    	loginModel.setName(joinData.get("name"));
    	loginModel.setBirth(joinData.get("birth"));
    	loginModel.setPhoneNumber(joinData.get("phoneNumber"));
    	loginModel.setAddress(joinData.get("address"));
    	
    	boolean result = manager.setJoin(loginModel);
    	String bool;
    	if(result){bool = "true";}
    	else{bool = "false";}
    	return bool;
    }
/*-------------------------------------------------------------------------------------------------------
 * 	LOGIN PAGE
 * ------------------------------------------------------------------------------------------------------
 */
	
	
	
	
	@RequestMapping(value = "/logIn", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String logIn(@RequestBody Map<String, String> logData, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String name = manager.setLog(logData); 
    	return name;
    }
	@RequestMapping(value = "/logError", method = RequestMethod.GET)
	public String logError() {
		return "logError";
	}	
	
	@RequestMapping(value = "/t", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String ttt(@RequestBody HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String name = "byung jun jung";
    	return name;
    }
	
	@RequestMapping(value = "/test3", method = RequestMethod.GET)
	public String test() {
		return "test";
	}	
/*-------------------------------------------------------------------------------------------------------
 * 	FUNCTIONS
 * ------------------------------------------------------------------------------------------------------
*/	
 
	
	
	
	
	
	
	

    
    
}
