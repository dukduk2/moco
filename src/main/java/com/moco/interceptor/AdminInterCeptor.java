package com.moco.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.moco.finalProject.HomeController;
import com.moco.member.MemberDTO;

@Component
public class AdminInterCeptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		System.out.println("===================== START ADMIN INTERCEPTOR =====================");
		// HTTP 요청 처리 전 수행할 로직 작성
		boolean adminCheck = false;
		if(((MemberDTO)request.getSession().getAttribute("memberDTO")).getId().equals("admin")){
			System.out.println("Admin True");
			adminCheck = !adminCheck;
		}else{
			System.out.println("Admin False");
			adminCheck = false;
			response.sendRedirect("/finalProject/#go");
		}
		
		return adminCheck;
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3) throws Exception {
		System.out.println("===================== END ADMIN INTERCEPTOR =====================");
	}

}
