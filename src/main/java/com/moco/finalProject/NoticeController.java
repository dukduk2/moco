package com.moco.finalProject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moco.notice.NoticeDTO;
import com.moco.notice.NoticeService;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Controller
@RequestMapping(value="/notice/")
public class NoticeController {

	@Inject
	private NoticeService noticeService;
	
	@RequestMapping(value="noticeList", method=RequestMethod.GET)
	public void noticeList(Integer curPage, Integer perPage, Model model) throws Exception{
		Map<String, Object> map=new HashMap<String, Object>();
		//String name=((MemberDTO)session.getAttribute("memberDTO")).getName();
		
		if(curPage==null){
			curPage=1;
		}
		if(perPage==null){
			perPage=10;
		}
		map.put("curPage", curPage);
		map.put("perPage", perPage);
		
		RowMaker rowMaker=new RowMaker();
		rowMaker.makeRow(curPage, perPage);
		
		map.put("startRow", rowMaker.getStartRow());
		map.put("lastRow", rowMaker.getLastRow());
		
		PageMaker pageMaker=new PageMaker(curPage, perPage);
		int totalCount=noticeService.totalCount();
		PageResult pageResult=pageMaker.paging(totalCount);
		List<NoticeDTO> ar=noticeService.noticeList(map);
		
		model.addAttribute("map", map);
		model.addAttribute("pageResult", pageResult);
		model.addAttribute("list", ar);
		//model.addAttribute("totalCount", totalCount);

		
	}
}
