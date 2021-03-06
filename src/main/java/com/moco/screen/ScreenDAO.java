package com.moco.screen;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ScreenDAO {
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE = "ScreenMapper.";
	
	public int insert(ScreenDTO screenDTO) throws Exception {
		return sqlSession.insert(NAMESPACE+"insert", screenDTO);
	}
	public List<ScreenDTO> list(int multi_num) throws Exception{
		return sqlSession.selectList(NAMESPACE+"list", multi_num);
	}
	
	public int totalCount() throws Exception{
		return sqlSession.selectOne(NAMESPACE+"unCommitTotalCount");
	}
	//commit=0인 list
	public List<ScreenDTO> unCommitList() throws Exception{
		return sqlSession.selectList(NAMESPACE+"unCommitList");
	}
	//commit=0 & multi_num
	public List<ScreenDTO> unCommitListMultiNum(int multi_num) throws Exception{
		return sqlSession.selectList(NAMESPACE+"unCommitListMultiNum", multi_num);
	}
	
	public int delete(int multi_num)throws Exception{
		return sqlSession.delete(NAMESPACE+"delete", multi_num);
	}
	
}
