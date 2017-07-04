package com.moco.movieAPI.movieRecommend;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.movieRecommend.subDTO.AgeViewDTO;
import com.moco.movieAPI.movieRecommend.subDTO.DirectorDTO;
import com.moco.movieAPI.movieRecommend.subDTO.JjimRankDTO;
import com.moco.movieAPI.movieRecommend.subDTO.ReviewRankDTO;

@Service
public class RecommendService {

	@Inject
	RecommendDAO recommendDAO;

	// 장르별 추천 영화
	public List<BasicMovieDTO> genreList(Map<String, Object> map) throws Exception {
		return recommendDAO.genreList(map);
	}

	// director list
	public List<DirectorDTO> directorList() throws Exception{
		return recommendDAO.directorList();
	}

	// review list
	public List<ReviewRankDTO> reviewList() throws Exception{
		return recommendDAO.reviewList();
	}

	// jjim list
	public List<JjimRankDTO> jjimRankList() throws Exception{
		return recommendDAO.jjimRankList();
	}

	// recent list
	public List<BasicMovieDTO> recentList() throws Exception {
		return recommendDAO.recentList();
	}

	// 나이별 id 리스
	public List<String> ageGroupList(Map<String, Object> map) throws Exception{
		return recommendDAO.ageGroupList(map);
	}

	// 나이별 최다 관람 영화 리스트
	public List<AgeViewDTO> ageGroupViewList(Map<String, Object> map) throws Exception{
		return recommendDAO.ageGroupViewList(map);
	}
}
