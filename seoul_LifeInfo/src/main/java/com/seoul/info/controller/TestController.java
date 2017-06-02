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
public class TestController extends Applet {
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public ModelAndView test(Model model) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("test");
		mav.addObject("testData", "testData입니다.");
		
		return mav;
	}

	@RequestMapping(value = "/test/{abc}", method = RequestMethod.GET)
	public ModelAndView home(Model model, @PathVariable("abc") String def) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main");
		mav.addObject("testData", "testData입니다.");
		
		return mav;
	}	

	@RequestMapping(value = "/test/abc", method = RequestMethod.GET)
	public ModelAndView home(Model model) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("join");
		mav.addObject("testData", "testData입니다.");
		
		return mav;
	}	

	@RequestMapping(value = "/test", method = RequestMethod.POST)
    public @ResponseBody String join(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
		String data2 = "data hahahaha";

		return data2;
    }
    
}
