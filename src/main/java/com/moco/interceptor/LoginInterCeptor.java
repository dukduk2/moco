package com.moco.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class LoginInterCeptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// HTTP 요청 처리 전 수행할 로직 작성
		System.out.println("===================== START LOGIN INTERCEPTOR =====================");
		boolean loginCheck = false;
		if(request.getSession().getAttribute("memberDTO") == null){
			System.out.println("Login False");
			loginCheck = false;
			response.sendRedirect("/finalProject/#go");
		}else{
			System.out.println("Login True");
			loginCheck = !loginCheck;
		}
		
		return loginCheck;
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3) throws Exception {
		System.out.println("===================== END LOGIN INTERCEPTOR =====================");
	}

}
