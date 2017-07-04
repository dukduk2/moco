package com.moco.movieAPI.movieRecommend;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.movieRecommend.subDTO.AgeViewDTO;
import com.moco.movieAPI.movieRecommend.subDTO.DirectorDTO;
import com.moco.movieAPI.movieRecommend.subDTO.JjimRankDTO;
import com.moco.movieAPI.movieRecommend.subDTO.ReviewRankDTO;

@Repository
public class RecommendDAO {
	@Inject
	SqlSession sqlSession;
	private final String MAPPER_NAME = "BasicMovieRecommendMapper.";
	
	// 추천 영화
	public List<BasicMovieDTO> genreList(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(MAPPER_NAME+"movieList", map);
	}
	
	// director list
	public List<DirectorDTO> directorList() throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"directorList");
	}
	
	// review list
	public List<ReviewRankDTO> reviewList() throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"reviewRankList");
	}
	
	// jjim list
	public List<JjimRankDTO> jjimRankList() throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"jjimRankList");
	}
	
	// recent list
	public List<BasicMovieDTO> recentList() throws Exception {
		return sqlSession.selectList(MAPPER_NAME+"recentList");
	}
	
	// 나이별 id 리스
	public List<String> ageGroupList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"ageGroupList", map);
	}
	
	// 나이별 최다 관람 영화 리스트
	public List<AgeViewDTO> ageGroupViewList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"ageGroupViewList", map);
	}
}
