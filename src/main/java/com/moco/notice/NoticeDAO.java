package com.moco.notice;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO {
	
	@Inject
	private SqlSession sqlSession;
	private String namespace="NoticeMapper.";
	
	public List<NoticeDTO> noticeList(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(namespace+"noticeList", map);
	}
	
	public int totalCount() throws Exception{
		return sqlSession.selectOne(namespace+"totalCount");
	}
	
	public NoticeDTO noticeView(int num) throws Exception{
		return sqlSession.selectOne(namespace+"noticeView", num);
	}	
		
	public int noticeInsert(NoticeDTO noticeDTO) throws Exception{
		return sqlSession.insert(namespace+"noticeInsert", noticeDTO);
	}
	
	public int noticeUpdate(NoticeDTO noticeDTO) throws Exception{
		return sqlSession.update(namespace+"noticeUpdate", noticeDTO);
	}
	
	public int noticeDelete(int num) throws Exception{
		return sqlSession.delete(namespace+"noticeDelete", num);
	}
	
	public int hitUpdate(boolean check, int num) throws Exception{
		if(check){
			return sqlSession.update(namespace+"hitUpdate1", num);
		}else{
			return sqlSession.update(namespace+"hitUpdate2", num);
		}
	}
}
