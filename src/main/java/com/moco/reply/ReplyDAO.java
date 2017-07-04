package com.moco.reply;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE = "ReplyMapper.";
	
	// replySelectList
	public List<ReplyDTO> replySelectList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(NAMESPACE+"replySelectList", map);
	}
	// replyTotalCount
	public int replyTotalCount(ReplyDTO replyDTO) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"replyTotalCount", replyDTO);
	}
	// replySelectOne
	public ReplyDTO replySelectOne(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"replySelectOne", num);
	}
	// replyInsert
	public int replyInsert(ReplyDTO replyDTO) throws Exception{
		return sqlSession.insert(NAMESPACE+"replyInsert", replyDTO);
	}
	// replyUpdate
	public int replyUpdate(ReplyDTO replyDTO) throws Exception{
		return sqlSession.update(NAMESPACE+"replyUpdate", replyDTO);
	}
	// replyDelete
	public int replyDelete(int num) throws Exception{
		return sqlSession.delete(NAMESPACE+"replyDelete", num);
	}
	// replyDelete2
	public int replyDelete2(Map<String, Object> map) throws Exception{
		return sqlSession.delete(NAMESPACE+"replyDelete2", map);
	}
}
