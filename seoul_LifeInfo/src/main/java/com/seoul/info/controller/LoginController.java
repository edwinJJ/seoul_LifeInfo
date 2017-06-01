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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
		public String home(Model model) {
			return "main";
		}	
/*-------------------------------------------------------------------------------------------------------
 * 	JOIN PAGE
 * ------------------------------------------------------------------------------------------------------
 */
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String home() {
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
    	
    	manager.setJoin(loginModel);
    	
    	return null;
    }
/*-------------------------------------------------------------------------------------------------------
 * 	LOGIN PAGE
 * ------------------------------------------------------------------------------------------------------
 */
	@RequestMapping(value = "/logIn", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String logIn(@RequestBody Map<String, String> logData, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	manager.setLog(logData);
    	return null;
    }
    
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String logTest(HttpServletRequest request, HttpServletRequest response) {
		
		HttpSession session = request.getSession(false);
		String nameInBrowser = (String) session.getAttribute("name");
		String Name;
		
	if(nameInBrowser==null||nameInBrowser.equals("")){
		session.setAttribute("name", controllerName);
	     Name = (String) session.getAttribute("name");
	    controllerName = "" ;
	}else{
		Name = nameInBrowser;
	}
	
		if(Name==null||Name.equals("")){
		session.removeAttribute("name");	
			return "logError";}
		else{ return "main";}

	    
	}	
/*-------------------------------------------------------------------------------------------------------
 * 	FUNCTIONS
 * ------------------------------------------------------------------------------------------------------
*/	
 String controllerName = "";	
	public String getLog(String name) throws Exception {
		if(name != null){
		   controllerName = name;
			
		}else{
			System.out.println("failed at controller");
		}
		return null;
	}
	
	
	
	
	

    
    
}
