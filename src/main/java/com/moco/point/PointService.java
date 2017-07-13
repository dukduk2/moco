package com.moco.point;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.moco.member.MemberDTO;
import com.moco.util.RowMaker;

@Service
public class PointService {

	@Autowired
	private PointDAO pointDAO;

	// pointList
	public List<PointDTO> pointList(int curPage, String id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		RowMaker rowMaker = new RowMaker();
		rowMaker.makeRow(curPage, 10);
		map.put("row", rowMaker);
		return pointDAO.pointList(map);
	}
	
	// benefit, point 구해오기
	public void getPoint(String grade, Model model) throws Exception{
		double percent = 0.0;
		int benefit = 0;
		int point = 0;
		if(grade.equals("일반")){
			percent = 0.05;
		}else if(grade.equals("브론즈")){
			percent = 0.10;
		}else if(grade.equals("실버")){
			percent = 0.15;
		}else if(grade.equals("골드")){
			percent = 0.20;
		}else{
			percent = 0.25;
		}
		
		benefit = (int)(5000*percent);
		point = benefit+5000;
		
		model.addAttribute("percent", percent);
		model.addAttribute("benefit", benefit);
		model.addAttribute("point", point);
		
	}
	
	// pointInsert
	public int pointInsert(PointDTO pointDTO, HttpSession session) throws Exception{
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("memberDTO");
		int result = 0;
		// 현금 결제시
		if(pointDTO.getKind().equals("현금/무통장")){
			// pointDB에 insert
			result = pointDAO.pointInsert(pointDTO);			
		// 좋아요 결제시
		}else{
			// pointDB에 insert
			result = pointDAO.pointInsert(pointDTO);
			// 현재 있는 likes
			int avlikes = memberDTO.getAvaliableLikes();
			// 사용한 likes
			int pointLikes = pointDTO.getLikes();
			// 남은 likes로 memberTableUpdate
			memberDTO.setAvaliableLikes(avlikes-pointLikes);
			pointDAO.avaliableLikesUpdate(memberDTO);
			// update 된 정보를 다시 세션에 저장하자
			session.setAttribute("memberDTO", memberDTO);
		}
		return result;
	}

	// totalCount
	public int totalCount(String id) throws Exception{
		return pointDAO.totalCount(id);
	}

}
