package com.moco.interceptor;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.moco.member.MemberDTO;
import com.moco.movieSchedule.MovieScheduleDTO;
import com.moco.movieSchedule.MovieScheduleService;

@Component
public class StreamingInterCeptor extends HandlerInterceptorAdapter{
	
	@Autowired
	private MovieScheduleService movieScheduleService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		System.out.println("==================== 스트리밍 시간체크 ====================");
		boolean check = false;

		// Client 접속 시간
		String id = ((MemberDTO)request.getSession().getAttribute("memberDTO")).getId();
		Date curDate = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("HHmm");
		String clientTime = simpleDateFormat.format(curDate);
		System.out.println(id+" 님의 접속 시간 : "+ clientTime);
		
		// playTime
		MovieScheduleDTO movieScheduleDTO = movieScheduleService.sysdateMovie();
		int playTime = movieScheduleService.getPlayTime(movieScheduleDTO.getPnum());
		// 2분 더주기
		playTime += 2;

		// 영화 startTime >> 19시58분으로 셋팅
		int startH = 19;
		int startM = 58;
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, startH);
		calendar.set(Calendar.MINUTE, startM);
		String movieStart =  simpleDateFormat.format(calendar.getTime());
		System.out.println("영화 >> "+movieScheduleDTO.getTitle()+" 의 시작 시간 : "+movieStart);
		
		// 영화 endTime
		calendar.add(Calendar.MINUTE, playTime);
		String movieEnd = simpleDateFormat.format(calendar.getTime());
		System.out.println("영화 >> "+movieScheduleDTO.getTitle()+" 의 종료 시간 : "+movieEnd);
		
		// 클라이언트 접속 시간이 스타트 시간~ 엔드 시간 안에 없다면 fasle.
		int user = Integer.parseInt(clientTime);
		int start = Integer.parseInt(movieStart);
		int end = Integer.parseInt(movieEnd);
		if(user>=start && user<=end){
			check = !check;
		}else{
			response.sendRedirect("/finalProject/movie/movieSchedule/error405");
		}
		
		return check;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		System.out.println("==================== 스트리밍 시간체크 끝 ====================");
		super.postHandle(request, response, handler, modelAndView);
	}
	
}
