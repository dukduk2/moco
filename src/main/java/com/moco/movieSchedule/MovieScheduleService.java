package com.moco.movieSchedule;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Service
public class MovieScheduleService {

	@Autowired
	private MovieScheduleDAO movieScheduleDAO;

	public List<MovieScheduleDTO> movieScheduleShow() throws Exception{
		System.out.println("-- MovieScheduleService -> Show");
		
		return movieScheduleDAO.movieScheduleShow();
	}
	
	public int movieScheduleAdd(MovieScheduleDTO movieScheduleDTO) throws Exception{
		System.out.println("-- MovieScheduleService -> Add");
		
		return movieScheduleDAO.movieScheduleAdd(movieScheduleDTO);
	}
	
	public String paidMovieCheck1(int pnum) throws Exception{
		System.out.println("-- MovieScheduleService -> paidMovieCheck1");
		
		return movieScheduleDAO.paidMovieCheck1(pnum);
	}
	
	public Date paidMovieCheck2(Date moviedate) throws Exception{
		System.out.println("-- MovieScheduleService -> paidMovieCheck2");
		
		return movieScheduleDAO.paidMovieCheck2(moviedate);
	}

	public Map<String, Object> movieScheduleList(int curPage, String search) throws Exception{
		System.out.println("-- MovieScheduleService -> List");
		
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pageMaker = new PageMaker(curPage);
		RowMaker rowMaker = pageMaker.getRowMaker();
		PageResult pageResult = pageMaker.paging(movieScheduleDAO.movieScheduleCount(search));
		
		map.put("list", movieScheduleDAO.movieScheduleList(rowMaker, search));
		map.put("pageResult", pageResult);
		
		return map;
	}

	public int movieScheduleDelete(int num) throws Exception{
		System.out.println("-- MovieScheduleService -> Delete");
		
		return movieScheduleDAO.movieScheduleDelete(num);
	}
}
