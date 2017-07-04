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
	public List<String> nationList() throws Exception{
		return basicMovieDAO.nationList();
	}
	// totalCount
	public int totalCount(Map<String, Object> map) throws Exception{
		return basicMovieDAO.totalCount(map);
	}
	// view
	public BasicMovieDTO view(int num) throws Exception{
		return basicMovieDAO.view(num);
	}
	// 찜하기 확인
	public JjimDTO jjimCheck(JjimDTO jjimDTO) throws Exception{
		return basicMovieDAO.jjimCheck(jjimDTO);
	}
	// 찜하기 INSERT
	public int jjimInsert(JjimDTO jjimDTO) throws Exception{
		return basicMovieDAO.jjimInsert(jjimDTO);
	}
	// 찜하기 DELETE
	public int jjimDelete(JjimDTO jjimDTO) throws Exception{
		return basicMovieDAO.jjimDelete(jjimDTO);
	}
	// 리뷰 참여 명 수
	public int reviewCount(int bNum) throws Exception{
		return basicMovieDAO.reviewCount(bNum);
	}
}
