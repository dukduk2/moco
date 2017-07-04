package com.moco.lowpricemovie;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moco.jjim.JjimDTO;
import com.moco.util.RowMaker;

@Repository
public class LowPriceMovieDAO {

	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE = "LowPriceMovieMapper.";
	
	//TOTAL COUNT
	public int totalCount(String kind, String search) throws Exception{
		Map<String, String> map = new HashMap<String, String>();
		map.put("kind", kind);
		map.put("search", search);
		int total = sqlSession.selectOne(NAMESPACE+"totalCount", map);
		return total;
	}
	
	//LIST
	public List<LowPriceMovieDTO> list(RowMaker rowMaker, String kind, String search) throws Exception{
		List<LowPriceMovieDTO> ar = new ArrayList<LowPriceMovieDTO>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kind", kind);
		map.put("search", search);
		map.put("row", rowMaker);
		ar = sqlSession.selectList(NAMESPACE+"list", map);
		return ar;
	}
	
	//VIEW
	public LowPriceMovieDTO view(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"view", num);
	}
	
	//DELETE
	public int delete(int num) throws Exception{
		return sqlSession.delete(NAMESPACE+"delete", num);
	}
	
	//insert
	public int insert(LowPriceMovieDTO lowPriceMovieDTO) throws Exception{
		return sqlSession.insert(NAMESPACE+"insert", lowPriceMovieDTO);
	}
	
	//update
	public int update(LowPriceMovieDTO lowPriceMovieDTO) throws Exception{
		System.out.println(lowPriceMovieDTO.getNum());
		System.out.println(lowPriceMovieDTO.getPub_date());
		System.out.println(lowPriceMovieDTO.getWatching_rate());
		return sqlSession.update(NAMESPACE+"update", lowPriceMovieDTO);
	}
	
	// 찜하기 확인
	public JjimDTO jjimCheck(JjimDTO jjimDTO) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"jjimCheck", jjimDTO);
	}
	// 찜하기 INSERT
	public int jjimInsert(JjimDTO jjimDTO) throws Exception{
		return sqlSession.insert(NAMESPACE+"jjimInsert", jjimDTO);
	}
	// 찜하기 DELETE
	public int jjimDelete(JjimDTO jjimDTO) throws Exception{
		return sqlSession.delete(NAMESPACE+"jjimDelete", jjimDTO);
	}
	
}
