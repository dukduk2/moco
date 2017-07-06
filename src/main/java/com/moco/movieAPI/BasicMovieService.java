package com.moco.movieAPI;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moco.jjim.JjimDTO;

@Service
public class BasicMovieService {
	@Inject
	BasicMovieDAO basicMovieDAO;

	// 영화 INSERT
	public int insert(BasicMovieDTO basicMovieDTO) throws Exception{
		return basicMovieDAO.insert(basicMovieDTO);
	}
	// 독립영화 INSERT
	public int lowPriceInsert(BasicMovieDTO basicMovieDTO) throws Exception{
		return basicMovieDAO.lowPriceInsert(basicMovieDTO);
	}
	// 영화 리스트 뽑아오기
	public List<BasicMovieDTO> list(Map<String, Object> map) throws Exception{
		return basicMovieDAO.list(map);
	}
	// NATION 리스트 뽑아오기
	public List<String> nationList(Map<String, Object> map) throws Exception{
		return basicMovieDAO.nationList(map);
	}
	// totalCount
	public int totalCount(Map<String, Object> map) throws Exception{
		return basicMovieDAO.totalCount(map);
	}
	// view
	public BasicMovieDTO view(Map<String, Object> map) throws Exception{
		return basicMovieDAO.view(map);
	}
	// 찜하기 확인
	public JjimDTO jjimCheck(Map<String, Object> map) throws Exception{
		return basicMovieDAO.jjimCheck(map);
	}
	// 찜하기 INSERT
	public int jjimInsert(Map<String, Object> map) throws Exception{
		return basicMovieDAO.jjimInsert(map);
	}
	// 찜하기 DELETE
	public int jjimDelete(Map<String, Object> map) throws Exception{
		return basicMovieDAO.jjimDelete(map);
	}
	// 리뷰 참여 명 수
	public int reviewCount(Map<String, Object> map) throws Exception{
		return basicMovieDAO.reviewCount(map);
	}
}
