package com.moco.viewCheck;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.review.ReviewDTO;

@Repository
public class ViewCheckDAO {

	@Inject
	private SqlSession sqlSession;
	private static final String NAMESPACE = "ViewCheckMapper.";
	
	// check
	public ViewCheckDTO viewCheck(ViewCheckDTO viewCheckDTO) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"viewCheck", viewCheckDTO);
	}
	
	// insert
	public int viewCheckInsert(ViewCheckDTO viewCheckDTO) throws Exception{
		return sqlSession.insert(NAMESPACE+"viewCheckInsert", viewCheckDTO);
	}
	
	// delete
	public int viewCheckDelete(String id) throws Exception{
		return sqlSession.delete(NAMESPACE+"viewCheckDelete", id);
	}
	
	// viewCheckBnum - parameter : String , result : List<ViewCheckDTO>
	public List<ViewCheckDTO> viewCheckBnum(String id) throws Exception{
		return sqlSession.selectList(NAMESPACE+"viewCheckBnum", id);
	}
	// viewCheckBasicMovieList - parameter : int , result : List<BasicMovieDTO>
	public BasicMovieDTO viewCheckBasicMovieList(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"viewCheckBasicMovieOne", num);
	}
	
	// viewCheckLnum - parameter : String , result : List<ViewCheckDTO>
	public List<ViewCheckDTO> viewCheckLnum(String id) throws Exception{
		return sqlSession.selectList(NAMESPACE+"viewCheckLnum", id);
	}
	// viewCheckLowpriceMovieList - parameter : int , result : LowPriceMovieDTO
	public LowPriceMovieDTO viewCheckLowpriceMovieList(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"viewCheckLowpriceMovieOne", num);
	}
	
}
