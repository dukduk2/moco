package com.moco.movieSchedule;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.moco.paidMovie.PaidMovieDTO;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Service
public class MovieScheduleService {

	@Autowired
	private MovieScheduleDAO movieScheduleDAO;
	
	// 스트리밍 --------------------------------------------------------------------------------------------------------
	
	// getCurTime
	public void getCurTime(long curTime) throws Exception{ 
		//session.setAttribute("curTime", curTime);
	}
	
	// 지금 시간 vs 20:00~영화상영시간
	public boolean timeCheck(HttpSession session, int num) throws Exception{
		boolean commit = false;
		// curTime >> 20:00
		long curTime = (Long)(session.getAttribute("curTime"));
		// totalTime
		long totalTime = curTime+this.getPlayTime(num);
		// 클라이언트 시간
		java.util.Date n = new java.util.Date();
		long nowTime = n.getTime();
		if(nowTime>=curTime && nowTime<=totalTime){
			commit = !commit;
		}
		return commit;
	}
	
	
	// getPlayTime - pnum
	public long getPlayTime(int num) throws Exception{
		String playTime = "";
		// paidMovieDTO로 basic인지 low인지 판별
		PaidMovieDTO paidMovieDTO = movieScheduleDAO.kindGet(num);
		// basicMovie
		if(paidMovieDTO.getlNum() ==0){
			playTime = movieScheduleDAO.getPlayTime(paidMovieDTO.getbNum());
		// lowPriceMovie
		}else{
			playTime = movieScheduleDAO.getPlayTime2(paidMovieDTO.getlNum());
		}
		int play_time = Integer.parseInt(playTime.substring(0, playTime.indexOf("분")));
		long play = play_time*1000*60*1000;
		return play;
	}
	
	// sysdateMovie
	public MovieScheduleDTO sysdateMovie() throws Exception{
		return movieScheduleDAO.sysdateMovie();
	}

	// one1
	public String one1(int num) throws Exception{
		return movieScheduleDAO.one1(num);
	}
	// one2
	public String one2(int num) throws Exception{
		return movieScheduleDAO.one2(num);
	}

	// movie---------------------------------------------------------------------------
	public List<MovieScheduleDTO> movieScheduleShow() throws Exception{
		return movieScheduleDAO.movieScheduleShow();
	}

	public int movieScheduleAdd(MovieScheduleDTO movieScheduleDTO) throws Exception{
		return movieScheduleDAO.movieScheduleAdd(movieScheduleDTO);
	}

	public String paidMovieCheck1(int pnum) throws Exception{
		return movieScheduleDAO.paidMovieCheck1(pnum);
	}

	public Date paidMovieCheck2(Date moviedate) throws Exception{
		return movieScheduleDAO.paidMovieCheck2(moviedate);
	}

	public Map<String, Object> movieScheduleList(int curPage, String search) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pageMaker = new PageMaker(curPage);
		RowMaker rowMaker = pageMaker.getRowMaker();
		PageResult pageResult = pageMaker.paging(movieScheduleDAO.movieScheduleCount(search));

		map.put("list", movieScheduleDAO.movieScheduleList(rowMaker, search));
		map.put("pageResult", pageResult);

		return map;
	}

	public int movieScheduleDelete(int num) throws Exception{
		return movieScheduleDAO.movieScheduleDelete(num);
	}
}
