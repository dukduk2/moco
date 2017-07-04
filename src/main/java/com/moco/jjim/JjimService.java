package com.moco.jjim;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.movieAPI.BasicMovieDTO;

@Service
public class JjimService {

	@Autowired
	private JjimDAO jjimDAO;

	// insert
	public int jjimInsert(JjimDTO jjimDTO) throws Exception{
		return jjimDAO.jjimInsert(jjimDTO);
	}
	// delete
	public int jjimDelete(JjimDTO jjimDTO) throws Exception{
		return jjimDAO.jjimDelete(jjimDTO);
	}
	// delete - 회원탈퇴 시
	public int jjimDeleteMember(String id) throws Exception{
		return jjimDAO.jjimDeleteMember(id);
	}

	// jjimBasicMovieList
	public List<BasicMovieDTO> jjimBasicOne(String id) throws Exception{
		List<BasicMovieDTO> ar = new ArrayList<BasicMovieDTO>();
		List<JjimDTO> jjimDTOs = jjimDAO.jjimBnum(id);
		for (JjimDTO jjimDTO : jjimDTOs) {
			int num = jjimDTO.getbNum();
			ar.add(jjimDAO.jjimBasicOne(num));
		}
		return ar;
	}
	// jjimLowPriceMovieList
	public List<LowPriceMovieDTO> jjimLowOne(String id) throws Exception{
		List<LowPriceMovieDTO> ar = new ArrayList<LowPriceMovieDTO>();
		List<JjimDTO> jjimDTOs = jjimDAO.jjimLnum(id);
		for (JjimDTO jjimDTO : jjimDTOs) {
			int num = jjimDTO.getlNum();
			ar.add(jjimDAO.jjimLowOne(num));
		}
		return ar;
	}
}
