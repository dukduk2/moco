package com.moco.point;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moco.member.MemberDTO;

@Repository
public class PointDAO {

	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE = "PointMapper.";
	
	// pointList
	public List<PointDTO> pointList(Map<String, Object> map) throws Exception{
		List<PointDTO> ar = sqlSession.selectList(NAMESPACE+"pointList", map);
		return sqlSession.selectList(NAMESPACE+"pointList", map);
	}
	
	// pointInsert
	public int pointInsert(PointDTO pointDTO) throws Exception{
		return sqlSession.insert(NAMESPACE+"pointInsert", pointDTO);
	}
	
	// avaliableLikesUpdate
	public int avaliableLikesUpdate(MemberDTO memberDTO) throws Exception{
		return sqlSession.update(NAMESPACE+"avaliableLikesUpdate", memberDTO);
	}
	
	// totalCount
	public int totalCount(String id) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"totalCount", id);
	}
}
