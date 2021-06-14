package com.example.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {		
		if(request.getSession().getAttribute("user_id") == null){
			//가려고했던 주소를 기억
			String path = request.getServletPath();
			System.out.println("path:" + path);
			String query = request.getQueryString();
			if(query == null || query.equals("")){
				query="";
			}else{
				query="?"+query;
			}
			request.getSession().setAttribute("path", path + query);
			response.sendRedirect("/user/login");
		}
		return super.preHandle(request, response, handler);
	}
	
}
