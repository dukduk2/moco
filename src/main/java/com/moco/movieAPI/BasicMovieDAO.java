package com.moco.movieAPI;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Component;

import com.moco.jjim.JjimDTO;

@Component
public class BasicMovieDAO {
	@Inject
	SqlSession sqlSession;
	private final String MAPPER_NAME = "BasicMovieMapper.";
	
	// 영화 INSERT
	public int insert(BasicMovieDTO basicMovieDTO) throws Exception{
		return sqlSession.insert(MAPPER_NAME+"insert", basicMovieDTO);
	}
	// 독립영화 INSERT
	public int lowPriceInsert(BasicMovieDTO basicMovieDTO) throws Exception{
		return sqlSession.insert(MAPPER_NAME+"lowPriceInsert", basicMovieDTO);
	}
	// 영화 삭제
	public int movieInfoDelete(Map<String, Object> map) throws Exception{
		return sqlSession.delete(MAPPER_NAME+"movieInfoDelete", map);
	}
	// 영화 리스트 뽑아오기
	public List<BasicMovieDTO> list(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"list", map);
	}
	// NATION 리스트 뽑아오기
	public List<String> nationList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"nationList", map);
	}
	// totalCount
	public int totalCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(MAPPER_NAME+"totalCount", map);
	}
	// view
	public BasicMovieDTO view(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(MAPPER_NAME+"view", map);
	}
	// 찜하기 확인
	public JjimDTO jjimCheck(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(MAPPER_NAME+"jjimCheck", map);
	}
	// 찜하기 INSERT
	public int jjimInsert(Map<String, Object> map) throws Exception{
		return sqlSession.insert(MAPPER_NAME+"jjimInsert", map);
	}
	// 찜하기 DELETE
	public int jjimDelete(Map<String, Object> map) throws Exception{
		return sqlSession.delete(MAPPER_NAME+"jjimDelete", map);
	}
	// 리뷰 참여 명 수
	public int reviewCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(MAPPER_NAME+"reviewCount", map);
	}
}
