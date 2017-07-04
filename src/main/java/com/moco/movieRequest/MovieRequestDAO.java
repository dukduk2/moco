package com.moco.movieRequest;

import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.movieAPI.BasicMovieDTO;

@Repository
public class MovieRequestDAO {

	@Inject
	private SqlSession sqlSession;
	private static final String NAMESPACE = "MovieRequestMapper.";
	
	// ForList
	public List<MovieRequestDTO> movieRequestForList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(NAMESPACE+"movieRequestForList", map);
	}
	public BasicMovieDTO basicMovieList(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"basicMovieList", num);
	}
	public BasicMovieDTO lowPriceMovieList(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"lowPriceMovieList", num);
	}
	// movieRequestTotalCount
	public int movieRequestTotalCount() throws Exception{
		return sqlSession.selectOne(NAMESPACE+"movieRequestTotalCount");
	}
	
	// insert
	public int movieRequestInsert(Map<String, Object> map) throws Exception{
		return sqlSession.insert(NAMESPACE+"movieRequestInsert", map);
	}
	
	// select
	public MovieRequestDTO movieRequestSelectOne(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"movieRequestSelectOne", map);
	}
}
