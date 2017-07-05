package com.moco.season;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SeasonDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE = "SeasonMapper.";
	
	// likesAbleCheck
	public int likesAbleCheck(SeasonDTO seasonDTO) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"likesAbleCheck", seasonDTO);
	}
	
	// adminOrderSelect - parameter > String kind , result > List<SeasonDTO>
	public List<SeasonDTO> adminOrderSelect(String kind) throws Exception{
		return sqlSession.selectList(NAMESPACE+"adminOrderSelect", kind);
	}

	// adminOrderSelect - parameter > String kind , result > List<SeasonDTO>
	public List<SeasonDTO> adminOrderSelect2(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(NAMESPACE+"adminOrderSelect2", map);
	}
	
	// adminOrderSelectOne - parameter String kind, result > SeasonDTO
	public SeasonDTO adminOrderSelectOne(String kind) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"adminOrderSelectOne", kind);
	}
	
	// adminOrderInsert - parameter SeasonDTO
	public int adminOrderInsert(SeasonDTO seasonDTO) throws Exception{
		return sqlSession.insert(NAMESPACE+"adminOrderInsert", seasonDTO);
	}
	
	// adminOrderStart - parameter int
	public int adminOrderStart(int num) throws Exception{
		return sqlSession.update(NAMESPACE+"adminOrderStart", num);
	}
	
	// adminOrderEnd - parameter int
	public int adminOrderEnd(int num) throws Exception{
		return sqlSession.update(NAMESPACE+"adminOrderEnd", num);
	}
	
	//adminOrderDelete - parameter int
	public int adminOrderDelete(int num) throws Exception{
		return sqlSession.delete(NAMESPACE+"adminOrderDelete", num);
	}
	
	// adminOrderCheck - parameter String , ResultType SeasonDTO
	public SeasonDTO adminOrderCheck(String kind) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"adminOrderCheck", kind);
	}
	
	// seasonTotalCount
	public int seasonTotalCount(String kind) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"seasonTotalCount", kind);
	}
	
}
