package com.moco.paidMovie;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DaoSupport;
import org.springframework.stereotype.Service;

import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieRequest.MovieRequestDTO;

@Service
public class PaidMovieService {

	@Autowired
	private PaidMovieDAO paidMovieDAO;

	public String movieGetTitle(PaidMovieDTO paidMovieDTO) throws Exception{
		// basicMovie
		String title = "";
		if(paidMovieDTO.getlNum() == 0){
			title = paidMovieDAO.basicTitle(paidMovieDTO.getbNum());
		}else{
			title = paidMovieDAO.lowTitle(paidMovieDTO.getlNum());
		}
		return title;
	}
	
	// movieRequest에 있는 영화가 upload 된다면, movieReqeustTable에서 삭제하기
	public int movieRequestDelete(PaidMovieDTO paidMovieDTO) throws Exception{
		MovieRequestDTO movieRequestDTO = new MovieRequestDTO();
		movieRequestDTO.setbNum(paidMovieDTO.getbNum());
		movieRequestDTO.setlNum(paidMovieDTO.getlNum());
		return paidMovieDAO.movieRequestDelete(movieRequestDTO);
	}

	// Kind, num으로 어떤 영화인지 알아오기
	public String kindFind(String movieTitle, int movieNum) throws Exception{
		String movieKind = "basicMovie";
		BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
		basicMovieDTO.setNum(movieNum);
		basicMovieDTO.setTitle(movieTitle);
		basicMovieDTO = paidMovieDAO.basicSearch(basicMovieDTO);
		if(basicMovieDTO == null){
			movieKind = "lowPriceMovie";
		}
		return movieKind;
	}

	// movieKind별로 DTO 셋팅
	public PaidMovieDTO DTOSet(PaidMovieDTO paidMovieDTO, String movieKind, int movieNum) throws Exception{
		if(movieKind.equals("basicMovie")){
			paidMovieDTO.setbNum(movieNum);
			paidMovieDTO.setlNum(0);
		}else{
			paidMovieDTO.setlNum(movieNum);
			paidMovieDTO.setbNum(0);
		}
		return paidMovieDTO;
	}

	// movieList
	public List<PaidMovieDTO> movieList(Map<String, Object> map) throws Exception{
		return paidMovieDAO.movieList(map);
	}
	// movieOne
	public PaidMovieDTO movieOne(int num) throws Exception{
		return paidMovieDAO.movieOne(num);
	}
	// movieInsert
	public int movieInsert(PaidMovieDTO paidMovieDTO) throws Exception{
		return paidMovieDAO.movieInsert(paidMovieDTO);
	}
	// movieUpdate
	public int movieUpdate(PaidMovieDTO paidMovieDTO) throws Exception{
		return paidMovieDAO.movieUpdate(paidMovieDTO);
	}
	// movieDelete
	public int movieDelete(String fileName) throws Exception{
		return paidMovieDAO.movieDelete(fileName);
	}
	// movieTotalCount
	public int movieTotalCount(String search) throws Exception{
		return paidMovieDAO.movieTotalCount(search);
	}
	// movieSelectOne(basic, low)
	public PaidMovieDTO paidMovieSelectOne(Map<String, Object> map) throws Exception{
		return paidMovieDAO.paidMovieSelectOne(map);
	}
	// basicMovieList
	public List<PaidMovieDTO> basicMovieList() throws Exception{
		return paidMovieDAO.basicMovieList();
	}
	// lowMovieList
	public List<PaidMovieDTO> lowMovieList() throws Exception{
		return paidMovieDAO.lowMovieList();
	}
	
	//eunji
	public List<BasicMovieDTO> payMovieBasic(Map<String, Object> map) throws Exception{
		return paidMovieDAO.payMovieBasic(map);
	}
	
	public List<LowPriceMovieDTO> payMovieLow(Map<String, Object> map) throws Exception{
		return paidMovieDAO.payMovieLow(map);
	}
	
	public int payMovieBasicCount() throws Exception{
		return paidMovieDAO.payMovieBasicCount();
	}
	
	public int payMovieLowCount() throws Exception{
		return paidMovieDAO.payMovieLowCount();
	}

}
