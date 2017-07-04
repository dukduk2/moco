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
	// 영화 리스트 뽑아오기
	public List<BasicMovieDTO> list(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"list", map);
	}
	// NATION 리스트 뽑아오기
	public List<String> nationList() throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"nationList");
	}
	// totalCount
	public int totalCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(MAPPER_NAME+"totalCount", map);
	}
	// view
	public BasicMovieDTO view(int num) throws Exception{
		return sqlSession.selectOne(MAPPER_NAME+"view", num);
	}
	// 찜하기 확인
	public JjimDTO jjimCheck(JjimDTO jjimDTO) throws Exception{
		return sqlSession.selectOne(MAPPER_NAME+"jjimCheck", jjimDTO);
	}
	// 찜하기 INSERT
	public int jjimInsert(JjimDTO jjimDTO) throws Exception{
		return sqlSession.insert(MAPPER_NAME+"jjimInsert", jjimDTO);
	}
	// 찜하기 DELETE
	public int jjimDelete(JjimDTO jjimDTO) throws Exception{
		return sqlSession.delete(MAPPER_NAME+"jjimDelete", jjimDTO);
	}
	// 리뷰 참여 명 수
	public int reviewCount(int bNum) throws Exception{
		return sqlSession.selectOne(MAPPER_NAME+"reviewCount", bNum);
	}
}
