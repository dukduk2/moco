package com.moco.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.moco.movieSchedule.MovieScheduleDTO;
import com.moco.util.RowMaker;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSession sqlSession;
	private final String namespace = "MemberMapper.";

	public int pointUpdate(MemberDTO memberDTO) throws Exception{
		return sqlSession.update(namespace+"pointUpdate", memberDTO);
	}
	
	public int memberJoin(MemberDTO memberDTO) throws Exception{		
		int result = sqlSession.insert(namespace+"memberJoin", memberDTO);
		
		return result;
	}
	
	public MemberDTO memberLogin(MemberDTO memberDTO) throws Exception{
		return sqlSession.selectOne(namespace+"memberLogin", memberDTO);
	}
	
	public MemberDTO memberView(MemberDTO memberDTO) throws Exception{
		return sqlSession.selectOne(namespace+"memberView", memberDTO);
	}

	public int memberDelete(String id){
		int result = sqlSession.delete(namespace+"memberDelete", id);
		
		return result;
	}
	
	public int memberUpdate(MemberDTO memberDTO){
		int result = sqlSession.update(namespace+"memberUpdate", memberDTO); 
		
		return result;
	}
	
	public boolean memberIdCheck(String id){
		boolean flag = false;
		String checkId = "";
		
		checkId = sqlSession.selectOne(namespace+"memberIdCheck", id);

		if(checkId == null){
			flag = true;
		}
		
		return flag;
	}
	
	public int memberFileDelete(MemberDTO memberDTO){
		int result = sqlSession.update(namespace+"memberFileDelete", memberDTO);
		
		return result;
	}
	
	public List<MemberDTO> memberList(RowMaker rowMaker, String kind, String search){
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("rowMaker", rowMaker);
		map.put("kind", kind);
		map.put("search", search);
		
		return sqlSession.selectList(namespace+"memberList", map);
	}
	
	public int memberCount(String kind, String search) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		map.put("kind", kind);
		map.put("search", search);
		
		return sqlSession.selectOne(namespace+"memberCount",map);
	}
	
	public int managementUpdate(MemberDTO memberDTO){
		int result = sqlSession.update(namespace+"managementUpdate", memberDTO);
		
		return result;
	}
	
	public String memberSearchID(String name, String email){
		Map<String, String> map = new HashMap<String, String>();

		map.put("name", name);
		map.put("email", email);
		
		return sqlSession.selectOne(namespace+"memberSearchID", map);
	}
	
	public String memberQuestionCheck(String id){
		String checkQuestion = "존재하지 않는 아이디입니다.";
		
		checkQuestion = sqlSession.selectOne(namespace+"memberQuestionCheck", id);
		
		if(checkQuestion == null){
			checkQuestion = "ID를 확인하세요.";
		}
		
		return checkQuestion;
	}
	
	public String memberSearchPW(String id, String email, String answer){
		Map<String, String> map = new HashMap<String, String>();

		map.put("id", id);
		map.put("email", email);
		map.put("answer", answer);
		
		return sqlSession.selectOne(namespace+"memberSearchPW", map);
	}
	

	//add
	public String memberPermission(String id){
		return sqlSession.selectOne(namespace+"memberPermission", id);
	}
	
	public int adminStateCount() throws Exception{
		return sqlSession.selectOne(namespace+"adminStateCount");
	}
	//-------------
}
