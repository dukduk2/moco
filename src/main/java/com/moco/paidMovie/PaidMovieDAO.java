package com.moco.paidMovie;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieRequest.MovieRequestDTO;

@Repository
public class PaidMovieDAO {

	@Inject
	private SqlSession sqlSession;
	private static final String NAMESPACE = "PaidMovieMapper.";

	// basicTitle
	public String basicTitle(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"basicTitle", num);
	}
	// lowTitle
	public String lowTitle(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"lowTitle", num);
	}
	
	// movieList
	public List<PaidMovieDTO> movieList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(NAMESPACE+"movieList" , map);
	}
	// movieOne
	public PaidMovieDTO movieOne(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"movieOne", num);
	}
	// movieInsert
	public int movieInsert(PaidMovieDTO paidMovieDTO) throws Exception{
		return sqlSession.insert(NAMESPACE+"movieInsert", paidMovieDTO);
	}
	// movieUpdate
	public int movieUpdate(PaidMovieDTO paidMovieDTO) throws Exception{
		return sqlSession.update(NAMESPACE+"movieUpdate", paidMovieDTO);
	}
	// movieDelete
	public int movieDelete(String fileName) throws Exception{
		return sqlSession.delete(NAMESPACE+"movieDelete", fileName);
	}
	// movieTotalCount
	public int movieTotalCount(String search) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"movieTotalCount", search);
	}

	// movieSelectOne(basic, low)
	public PaidMovieDTO paidMovieSelectOne(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"paidMovieSelectOne", map);
	}


	// basicSearch
	public BasicMovieDTO basicSearch(BasicMovieDTO basicMovieDTO) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"basicSearch", basicMovieDTO);
	}
	// movieRequestDelete
	public int movieRequestDelete(MovieRequestDTO movieRequestDTO) throws Exception{
		return sqlSession.delete(NAMESPACE+"movieRequestDelete", movieRequestDTO);
	}
	// basicMovieList
	public List<PaidMovieDTO> basicMovieList() throws Exception{
		return sqlSession.selectList(NAMESPACE+"basicMovieList");
	}
	// lowMovieList
	public List<PaidMovieDTO> lowMovieList() throws Exception{
		return sqlSession.selectList(NAMESPACE+"lowMovieList");
	}
	
	//eunji
	public List<BasicMovieDTO> payMovieBasic(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(NAMESPACE+"payMovieBasic", map);
	}
	
	public List<LowPriceMovieDTO> payMovieLow(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(NAMESPACE+"payMovieLow", map);
	}
	
	public int payMovieBasicCount() throws Exception{
		return sqlSession.selectOne(NAMESPACE+"payMovieBasicCount");
	}
	
	public int payMovieLowCount() throws Exception{
		return sqlSession.selectOne(NAMESPACE+"payMovieLowCount");
	}

}
