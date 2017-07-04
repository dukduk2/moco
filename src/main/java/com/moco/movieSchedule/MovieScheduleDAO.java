package com.moco.movieSchedule;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moco.util.RowMaker;

@Repository
public class MovieScheduleDAO {

	@Autowired
	private SqlSession sqlSession;
	private final String namespace = "MovieScheduleMapper.";
	
	public List<MovieScheduleDTO> movieScheduleShow(){
		System.out.println("--- movieScheduleDAO -> Show");
		
		return sqlSession.selectList(namespace+"movieScheduleShow");
	}

	public List<MovieScheduleDTO> movieScheduleList(RowMaker rowMaker, String search){
		System.out.println("--- movieScheduleDAO -> List");
		
		Map<String, Object> map = new HashMap<String, Object>();

		String a = search.replace("-", "");
		
		map.put("rowMaker", rowMaker);
		map.put("search", a);
		
		return sqlSession.selectList(namespace+"movieScheduleList", map);
	}
	
	public int movieScheduleCount(String search) throws Exception {
		System.out.println("--- movieScheduleDAO -> Count");
		
		Map<String, String> map = new HashMap<String, String>();

		map.put("search", search);
		
		return sqlSession.selectOne(namespace+"movieScheduleCount",map);
	}
	
	public int movieScheduleAdd(MovieScheduleDTO movieScheduleDTO){
		System.out.println("--- MovieScheduleDAO -> movieManagementAdd");
		
		int result = sqlSession.insert(namespace+"movieScheduleAdd", movieScheduleDTO);
		
		return result;
	}
	
	public int movieScheduleDelete(int num){
		System.out.println("--- MovieScheduleDAO -> movieScheduleDelete");
		
		int result = sqlSession.delete(namespace+"movieScheduleDelete", num);
		
		return result;
	}
	
	public String paidMovieCheck1(int pnum){
		System.out.println("--- MovieScheduleDAO -> paidMovieCheck1");
		
		return sqlSession.selectOne(namespace+"paidMovieCheck1", pnum);
	}
	
	public Date paidMovieCheck2(Date moviedate){
		System.out.println("--- MovieScheduleDAO -> paidMovieCheck2");
		
		return sqlSession.selectOne(namespace+"paidMovieCheck2", moviedate);
	}
}
