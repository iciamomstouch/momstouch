package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CrawlingController {
	 //다음 날씨 크롤링
	 @ResponseBody
	 @RequestMapping("daum.json")
	 public HashMap<String, Object> daum()throws Exception{
		 HashMap<String, Object> array=new HashMap<String, Object>();
		 try {
			 Document doc=Jsoup.connect("http://www.daum.net").get();
			 Elements today=doc.select(".info_today");
			 array.put("date", today.select(".date_today").text());
			 Elements elements=doc.select(".list_weather");
			 ArrayList<HashMap<String, Object>> arrayToday=new ArrayList<HashMap<String, Object>>();
			 for(Element e:elements.select("li")) {
				 HashMap<String, Object> map=new HashMap<String, Object>();
				 map.put("part", e.select(".txt_part").text());
				 map.put("temper", e.select(".txt_temper").text());
				 map.put("wa", e.select(".ir_wa").text());
				 map.put("ico", e.select(".ico_ws").text());
				 arrayToday.add(map);
			 }
			 array.put("list", arrayToday);
		 }catch(Exception e) { 
		 System.out.println(e.toString());
		 }
		 return array;
	 }
}
