package com.seoul.info.controller;

import java.applet.Applet;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Locale;
import java.util.Map;
import java.util.zip.CheckedOutputStream;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionContext;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.omg.CORBA.portable.InputStream;
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
			String serviceKey = "PFJyYmaXuz%2FE2IV61aPlgeHf%2FQAGqJk0k7Io%2Fti7KWogBSoHwUU04RHS2O14y8XG2m0%2BXHHLomH1bavrz6zd9Q%3D%3D";
			serviceKey = URLEncoder.encode(serviceKey, "UTF-8");
	 
	        String urlPath = "http://openapi.gbis.go.kr/ws/rest/busarrivalservice/station?serviceKey=PFJyYmaXuz%2FE2IV61aPlgeHf%2FQAGqJk0k7Io%2Fti7KWogBSoHwUU04RHS2O14y8XG2m0%2BXHHLomH1bavrz6zd9Q%3D%3D&stationId=200000078";
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
	
	@RequestMapping(value = "/getBusStationData", produces = { "application/json;charset=UTF-8" }, method = RequestMethod.POST)
    public @ResponseBody String getBusStationData(@RequestBody Map<String, String> reqData) throws IOException{
		
		 StringBuilder urlBuilder = new StringBuilder("http://openapi.tago.go.kr/openapi/service/BusSttnInfoInqireService/getSttnNoList"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("PFJyYmaXuz%2FE2IV61aPlgeHf%2FQAGqJk0k7Io%2Fti7KWogBSoHwUU04RHS2O14y8XG2m0%2BXHHLomH1bavrz6zd9Q%3D%3D","UTF-8") + "=서비스키"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode("25", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("nodeNm","UTF-8") + "=" + URLEncoder.encode("전통시장", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("nodeNo","UTF-8") + "=" + URLEncoder.encode("44810", "UTF-8"));/*파라미터설명*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        System.out.println(sb.toString());
	   
		
		return sb.toString();
	}
	
    
}
