package com.moco.finalProject;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.moco.member.MemberDTO;
import com.moco.point.PointDTO;
import com.moco.point.PointService;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;

@Controller
@RequestMapping(value="/point/**")
public class PointController {
	
	@Inject
	private PointService pointService;
	
	@RequestMapping(value="pointList", method=RequestMethod.GET)
	public void pointList(HttpSession session, Integer curPage, Model model) throws Exception{
		if(curPage == null){
			curPage = 1;
		}
		
		String id = ((MemberDTO)session.getAttribute("memberDTO")).getId();
		model.addAttribute("pointList", pointService.pointList(curPage, id));
		
		// 페이징
		PageMaker pageMaker = new PageMaker(curPage, 10);
		PageResult pageResult = pageMaker.paging(pointService.totalCount(id));
		model.addAttribute("pageResult", pageResult);
		
		// benefit, point
		String grade = ((MemberDTO)session.getAttribute("memberDTO")).getGrade();
		pointService.getPoint(grade, model);
		
	}
	
	@RequestMapping(value="pointInsert", method=RequestMethod.POST)
	public void pointInsert(PointDTO pointDTO) throws Exception{
		
	}
	
}
