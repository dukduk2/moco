package com.moco.member;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Service
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	public int memberJoin(MemberDTO memberDTO) throws Exception{
		System.out.println("-- MemberService -> Join");
		
		int result = memberDAO.memberJoin(memberDTO);
		
		return result;
	}
	
	public MemberDTO memberLogin(MemberDTO memberDTO) throws Exception{
		System.out.println("-- MemberService -> Login");
		
		return memberDAO.memberLogin(memberDTO);
	}
	
	public MemberDTO memberView(MemberDTO memberDTO) throws Exception{
		System.out.println("-- MemberService -> View");
		
		return memberDAO.memberView(memberDTO);
	}
	
	public int memberDelete(String id) throws Exception{
		System.out.println("-- MemberService -> Delete");
		
		return memberDAO.memberDelete(id);
	}
	
	public int memberUpdate(MemberDTO memberDTO) throws Exception{
		System.out.println("-- MemberService -> Update");
		
		return memberDAO.memberUpdate(memberDTO);
	}
	
	public boolean memberIdCheck(String id) throws Exception{
		System.out.println("-- MemberService -> IdCheck");
		
		return memberDAO.memberIdCheck(id);
	}
	
	public int memberFileDelete(MemberDTO memberDTO) throws Exception{
		System.out.println("-- MemberService -> FileDelete");
		
		return memberDAO.memberFileDelete(memberDTO);
	}
	
	public Map<String, Object> memberList(int curPage, String kind, String search) throws Exception{
		System.out.println("-- MemberService -> List");
		
		Map<String, Object> map = new HashMap<String, Object>();
		PageMaker pageMaker = new PageMaker(curPage);
		RowMaker rowMaker = pageMaker.getRowMaker();
		PageResult pageResult = pageMaker.paging(memberDAO.memberCount(kind, search));
		
		map.put("list", memberDAO.memberList(rowMaker, kind, search));
		map.put("pageResult", pageResult);
		
		return map;
	}
	
	public int managementUpdate(MemberDTO memberDTO) throws Exception{
		System.out.println("-- MemberService -> managementUpdate");
		
		return memberDAO.managementUpdate(memberDTO);
	}
	
	public String memberSearchID(String name, String email) throws Exception{
		System.out.println("-- MemberService -> SearchID");
		
		return memberDAO.memberSearchID(name, email);
	}
	
	public String memberQuestionCheck(String id) throws Exception{
		System.out.println("-- MemberService -> QuestionCheck");
		
		return memberDAO.memberQuestionCheck(id);
	}
	
	public String memberSearchPW(String id, String email, String answer) throws Exception{
		System.out.println("-- MemberService -> SearchPW");
		
		return memberDAO.memberSearchPW(id, email, answer);
	}
	
	//add
	public String memberPermission(String id) throws Exception{
		System.out.println("-- MemberService -> Permission");
		
		return memberDAO.memberPermission(id);
	}
	
	public int adminStateCount() throws Exception{
		return memberDAO.adminStateCount();
	}
	//----------------
}
