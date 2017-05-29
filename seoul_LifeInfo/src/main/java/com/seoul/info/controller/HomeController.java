package com.seoul.info.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.seoul.info.manager.impl.TestManagerImpl;
import com.seoul.info.model.TestModel;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	TestManagerImpl manager;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}

    @RequestMapping(value = "/test", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String setDepartment(@RequestBody String data, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	manager.setData(data);
    	
    	return "bye";
    }
}
