package com.moco.viewCheck;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.movieAPI.BasicMovieDTO;

@Service
public class ViewCheckService {

	@Autowired
	private ViewCheckDAO viewCheckDAO;

	// viewCheckDTOSet
	public ViewCheckDTO viewCheckDTOSet(String boardKind, int boardNum, String id) throws Exception{
		ViewCheckDTO viewCheckDTO = new ViewCheckDTO();
		if(boardKind.equals("basicMovie")){
			viewCheckDTO.setbNum(boardNum);
			viewCheckDTO.setlNum(0);
		}else{
			viewCheckDTO.setbNum(0);
			viewCheckDTO.setlNum(boardNum);
		}
		viewCheckDTO.setId(id);

		return viewCheckDTO;
	}

	// check
	public boolean viewCheck(ViewCheckDTO viewCheckDTO) throws Exception{
		boolean check = false;
		viewCheckDTO = viewCheckDAO.viewCheck(viewCheckDTO);
		if(viewCheckDTO != null){ // 봤다면 true
			check = !check;
		}
		return check;
	}

	// insert
	public int viewCheckInsert(ViewCheckDTO viewCheckDTO) throws Exception{
		return viewCheckDAO.viewCheckInsert(viewCheckDTO);
	}

	// delete - 아이디를 삭제할 때
	public int viewCheckDelete(String id) throws Exception{
		return viewCheckDAO.viewCheckDelete(id);
	}

	//////////////////////////////////////////////////////////////////////////////////////////////
	// basicMovieList
	public List<BasicMovieDTO> viewCheckBasicMovieList(String id) throws Exception{
		// return 해 줄 BasicMovieDTO List타입을 만들어 놓는다.
		List<BasicMovieDTO> ar = new ArrayList<BasicMovieDTO>();
		// 받아온 id로 bnum들을 받아온다.
		List<ViewCheckDTO> nums = viewCheckDAO.viewCheckBnum(id);
		for (ViewCheckDTO viewCheckDTO : nums) {
			// num을 하나 꺼내서, basicMovieList를 꺼내온다.
			int num = viewCheckDTO.getbNum();
			System.out.println(num);
			 ar.add(viewCheckDAO.viewCheckBasicMovieList(num));
		}
		return ar;
	}
	// lowpriceMovieList
	public List<LowPriceMovieDTO> viewCheckLowPriceMovieList(String id) throws Exception{
		List<LowPriceMovieDTO> ar = new ArrayList<LowPriceMovieDTO>();
		List<ViewCheckDTO> nums = viewCheckDAO.viewCheckLnum(id);
		for (ViewCheckDTO viewCheckDTO : nums) {
			int num = viewCheckDTO.getlNum();
			System.out.println(num);
			ar.add(viewCheckDAO.viewCheckLowpriceMovieList(num));
		}
		return ar;
	}

}
