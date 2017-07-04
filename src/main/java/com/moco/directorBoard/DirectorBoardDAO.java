package com.moco.directorBoard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.moco.board.BoardDAO;
import com.moco.board.BoardDTO;

@Repository
public class DirectorBoardDAO implements BoardDAO{
	@Inject
	SqlSession sqlSession;
	private final String MAPPER_NAME = "DirectorBoardMapper.";
	
	@Override
	public List<BoardDTO> list(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(MAPPER_NAME+"list", map);
	}

	@Override
	public BoardDTO view(int num) throws Exception {
		return sqlSession.selectOne(MAPPER_NAME+"view", num);
	}

	@Override
	public int write(BoardDTO boardDTO) throws Exception {
		return sqlSession.insert(MAPPER_NAME+"write", boardDTO);
	}

	@Override
	public int update(BoardDTO boardDTO) throws Exception {
		return sqlSession.update(MAPPER_NAME+"update", boardDTO);
	}

	@Override
	public int delete(int num) throws Exception {
		return sqlSession.delete(MAPPER_NAME+"delete", num);
	}

	@Override
	public int totalCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(MAPPER_NAME+"totalCount", map);
	}

	@Override
	public void hitUpdate(int num, boolean flag) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("flag", flag);
		sqlSession.update(MAPPER_NAME+"hitUpdate", map);
	}
	
	public int stateUpdate() throws Exception{
		return sqlSession.update(MAPPER_NAME+"stateUpdate");
	}
	
	public List<DirectorBoardDTO> compareDate() throws Exception{
		return sqlSession.selectList(MAPPER_NAME+"compareDate");
	}
	
	public int stateUpdateFinish(int num) throws Exception{
		return sqlSession.update(MAPPER_NAME+"stateUpdateFinish", num);
	}

}
