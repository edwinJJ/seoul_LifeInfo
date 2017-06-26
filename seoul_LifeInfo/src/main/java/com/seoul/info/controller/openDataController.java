package com.seoul.info.controller;

import java.applet.Applet;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
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
public class openDataController extends Applet {
	
	@Inject
	LoginManagerImpl manager;
	
	@Inject
	LoginModel loginModel;
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	
	@RequestMapping(value = "/main/subway", method = RequestMethod.GET)
	public String subwayMain() {
		return "subwayMain";
	}	
 
	
	@RequestMapping(value = "/getSubwayData", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String getSubwayData(@RequestBody Map<String, String> reqData) throws UnsupportedEncodingException{
			
			String stationName = reqData.get("stationName");
			stationName = URLEncoder.encode(stationName, "utf-8");
			System.out.println(stationName);
	 
	        String urlPath = "http://swopenapi.seoul.go.kr/api/subway/sample/xml/realtimeStationArrival/1/5/"+stationName+"/";
	        String pageContents = "";
	        StringBuilder contents = new StringBuilder();
	        try{
	 
	            URL url = new URL(urlPath);
	            URLConnection con = (URLConnection)url.openConnection();
	            InputStreamReader reader = new InputStreamReader (con.getInputStream(), "utf-8");
	 
	            BufferedReader buff = new BufferedReader(reader);
	 
	            while((pageContents = buff.readLine())!=null){
	                //System.out.println(pageContents);             
	                contents.append(pageContents);
	                contents.append("\r\n");
	            }
	 
	            buff.close();
	 
	            System.out.println(contents.toString());
	 
	        }catch(Exception e){
	            e.printStackTrace();
	        }
	        
	        String str = contents.toString();
	        
	        
	        System.out.println(str);
	        
	        return str;
	 
	    }
	 
	
	
	
	
	
	
	@RequestMapping(value = "/main/weather", method = RequestMethod.GET)
	public String weatherMain() {
		return "weatherMain";
	}	
	
	
	@RequestMapping(value = "/getWeatherData", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String getWeatherData(@RequestBody Map<String, String> reqData) throws UnsupportedEncodingException{
			
			String location = reqData.get("weather");
			location = URLEncoder.encode(location, "utf-8");
			System.out.println(location);
	 
	        String urlPath = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=4113556000";
	        String pageContents = "";
	        StringBuilder contents = new StringBuilder();
	        try{
	 
	            URL url = new URL(urlPath);
	            URLConnection con = (URLConnection)url.openConnection();
	            InputStreamReader reader = new InputStreamReader (con.getInputStream(), "utf-8");
	 
	            BufferedReader buff = new BufferedReader(reader);
	 
	            while((pageContents = buff.readLine())!=null){
	                //System.out.println(pageContents);             
	                contents.append(pageContents);
	                contents.append("\r\n");
	            }
	 
	            buff.close();
	 
	            System.out.println(contents.toString());
	 
	        }catch(Exception e){
	            e.printStackTrace();
	        }
	        
	        String str = contents.toString();
	        
	        
	        System.out.println(str);
	        
	        return str;
	 
	    }
	
	
	
	
	
	@RequestMapping(value = "/main/dust", method = RequestMethod.GET)
	public String dustMain() {
		return "dustMain";
	}	
	
	
	@RequestMapping(value = "/getDustData", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String getDustData(@RequestBody Map<String, String> reqData) throws UnsupportedEncodingException{
			
			String date = reqData.get("date");
			String location = reqData.get("location");
			location = URLEncoder.encode(location, "utf-8");
			System.out.println(location);
	 
	        String urlPath = "http://openapi.seoul.go.kr:8088/sample/xml/DailyAverageAirQuality/1/5/"+date+"/"+location+"/";
	        String pageContents = "";
	        StringBuilder contents = new StringBuilder();
	        try{
	 
	            URL url = new URL(urlPath);
	            URLConnection con = (URLConnection)url.openConnection();
	            InputStreamReader reader = new InputStreamReader (con.getInputStream(), "utf-8");
	 
	            BufferedReader buff = new BufferedReader(reader);
	 
	            while((pageContents = buff.readLine())!=null){
	                //System.out.println(pageContents);             
	                contents.append(pageContents);
	                contents.append("\r\n");
	            }
	 
	            buff.close();
	 
	            System.out.println(contents.toString());
	 
	        }catch(Exception e){
	            e.printStackTrace();
	        }
	        
	        String str = contents.toString();
	        
	        
	        System.out.println(str);
	        
	        return str;
	 
	    }
	
	
	@RequestMapping(value = "/main/bus", method = RequestMethod.GET)
	public String busMain() {
		return "busMain";
	}	
	
	@RequestMapping(value = "/getBusData", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String getBusData(@RequestBody Map<String, String> reqData) throws UnsupportedEncodingException{
			
			String stationName = reqData.get("stationName");
			stationName = URLEncoder.encode(stationName, "utf-8");
			
			String addr = "http://openapi.gbis.go.kr/ws/busarrivalservice?wsdl"+"?ServiceKey=";
			String serviceKey = "t9HGmBLTVE2rpDHGGR%2F71x%2B%2FOsgyCqUIAMhrRFJIvnMvlzY2qy%2BDZzgVxnB2OZgsmUGycJl3AzRAEezcV%2FiVsA%3D%3D";
			String parameter = "";
			
			serviceKey = URLEncoder.encode(serviceKey, "UTF-8");
			
			 parameter = parameter + "&" + "stationId=209900003";
			 parameter = parameter + "&" + "routeId=100100282";
		
			addr = addr + serviceKey + parameter;
	 
	        String urlPath = addr;
	        String pageContents = "";
	        StringBuilder contents = new StringBuilder();
	        try{
	 
	            URL url = new URL(urlPath);
	            URLConnection con = (URLConnection)url.openConnection();
	            InputStreamReader reader = new InputStreamReader (con.getInputStream(), "utf-8");
	 
	            BufferedReader buff = new BufferedReader(reader);
	 
	            while((pageContents = buff.readLine())!=null){
	                System.out.println(pageContents);             
	                contents.append(pageContents);
	                contents.append("\r\n");
	            }
	 
	            buff.close();
	 
	            System.out.println(contents.toString());
	 
	        }catch(Exception e){
	            e.printStackTrace();
	        }
	        
	        String str = contents.toString();
	        
	        
	        System.out.println(str);
	        
	        return str;
	 
	    }
	
    
}
