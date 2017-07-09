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

	public int memberJoin(MemberDTO memberDTO) throws Exception{
		System.out.println("--- MemberDAO -> Join");
		
		int result = sqlSession.insert(namespace+"memberJoin", memberDTO);
		
		return result;
	}
	
	public MemberDTO memberLogin(MemberDTO memberDTO) throws Exception{
		System.out.println("--- MemberDAO -> Login");
		
		return sqlSession.selectOne(namespace+"memberLogin", memberDTO);
	}
	
	public MemberDTO memberView(MemberDTO memberDTO) throws Exception{
		System.out.println("--- MemberDAO -> View");
		
		return sqlSession.selectOne(namespace+"memberView", memberDTO);
	}

	public int memberDelete(String id){
		System.out.println("--- MemberDAO -> Delete");
		
		int result = sqlSession.delete(namespace+"memberDelete", id);
		
		return result;
	}
	
	public int memberUpdate(MemberDTO memberDTO){
		System.out.println("--- MemberDAO -> Update");
		
		int result = sqlSession.update(namespace+"memberUpdate", memberDTO); 
		
		return result;
	}
	
	public boolean memberIdCheck(String id){
		System.out.println("--- MemberDAO -> IdCheck");

		boolean flag = false;
		String checkId = "";
		
		checkId = sqlSession.selectOne(namespace+"memberIdCheck", id);
		
		System.out.println("DAO Id : "+checkId);
		
		if(checkId == null){
			flag = true;
			System.out.println(flag);
		}
		
		return flag;
	}
	
	public int memberFileDelete(MemberDTO memberDTO){
		System.out.println("--- MemberDAO -> fileDelete");
		
		int result = sqlSession.update(namespace+"memberFileDelete", memberDTO);
		
		return result;
	}
	
	public List<MemberDTO> memberList(RowMaker rowMaker, String kind, String search){
		System.out.println("--- MemberDAO -> List");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("rowMaker", rowMaker);
		map.put("kind", kind);
		map.put("search", search);
		
		return sqlSession.selectList(namespace+"memberList", map);
	}
	
	public int memberCount(String kind, String search) throws Exception {
		System.out.println("--- MemberDAO -> Count");
		
		Map<String, String> map = new HashMap<String, String>();

		map.put("kind", kind);
		map.put("search", search);
		
		return sqlSession.selectOne(namespace+"memberCount",map);
	}
	
	public int managementUpdate(MemberDTO memberDTO){
		System.out.println("--- MemberDAO -> managementUpdate");
		
		int result = sqlSession.update(namespace+"managementUpdate", memberDTO);
		
		return result;
	}
	
	public String memberSearchID(String name, String email){
		System.out.println("--- MemberDAO -> SearchID");
		
		Map<String, String> map = new HashMap<String, String>();

		map.put("name", name);
		map.put("email", email);
		
		return sqlSession.selectOne(namespace+"memberSearchID", map);
	}
	
	public String memberQuestionCheck(String id){
		System.out.println("--- MemberDAO -> QuestionCheck");

		String checkQuestion = "존재하지 않는 아이디입니다.";
		
		checkQuestion = sqlSession.selectOne(namespace+"memberQuestionCheck", id);
		
		if(checkQuestion == null){
			checkQuestion = "ID를 확인하세요.";
		}
		
		return checkQuestion;
	}
	
	public String memberSearchPW(String id, String email, String answer){
		System.out.println("--- MemberDAO -> SearchPW");
		
		Map<String, String> map = new HashMap<String, String>();

		map.put("id", id);
		map.put("email", email);
		map.put("answer", answer);
		
		return sqlSession.selectOne(namespace+"memberSearchPW", map);
	}
	

	//add
	public String memberPermission(String id){
		System.out.println("--- MemberDAO -> Permission");
		
		return sqlSession.selectOne(namespace+"memberPermission", id);
	}
	
	public int adminStateCount() throws Exception{
		return sqlSession.selectOne(namespace+"adminStateCount");
	}
	//-------------
}
