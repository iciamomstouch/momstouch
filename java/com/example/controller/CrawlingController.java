package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class CrawlingController {
	 //���� ���� ũ�Ѹ�
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
	//������ ũ�Ѹ�
	@RequestMapping("recipe.json")
	@ResponseBody
	public List<Map<String, Object>> moreJson(String url){
		List<Map<String, Object>> array = new ArrayList<>();
		
		System.setProperty("webdriver.chrome.driver", "c:/temp/chromedriver.exe");
		WebDriver driver = new ChromeDriver();
		driver.get(url);
		
		WebElement contents = driver.findElement(By.id("contents"));
		WebElement more = contents.findElement(By.className("link-more"));
		more.click();
		
		//1�ʵ��� ��ٸ���� �ǹ�
		try{			
			Thread.sleep(1000);			
		}catch(Exception e){
			System.out.println("����:" + e.toString());
		}
		
		List<WebElement> elements = driver.findElements(By.cssSelector(".sect-movie-chart ol li"));
		System.out.println("�����Ͱ���:" + elements.size());
		for(WebElement e:elements){
			Map<String, Object> map = new HashMap<>();
			String title = e.findElement(By.className("title")).getText();
			String image = e.findElement(By.tagName("img")).getAttribute("src");
			String date = e.findElement(By.className("txt-info")).getText();			
			map.put("title", title);
			map.put("image", image);
			map.put("date", date);
			array.add(map);				
		}		
		driver.quit();
		return array;
	}
}
