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
	
	@RequestMapping(value="noticeDelete", method=RequestMethod.GET)
	public String noticeDelete(int num) throws Exception{
		noticeService.noticeDelete(num);
		return "redirect:/notice/noticeList";
	}
	
	@RequestMapping(value="noticeUpdate", method=RequestMethod.GET)
	public String noticeUpdate(int num, Model model) throws Exception{
		model.addAttribute("dto", noticeService.noticeView(num));
		return "notice/noticeUpdate";
	}
	
	@RequestMapping(value="noticeUpdate", method=RequestMethod.POST)
	public String noticeUpdate(NoticeDTO noticeDTO, HttpSession session) throws Exception{
		noticeService.noticeUpdate(noticeDTO);
		
		return "redirect:/notice/noticeList";
	}
	
	@RequestMapping(value="noticeView", method=RequestMethod.GET)
	public String noticeView(int num, Model model) throws Exception{
		NoticeDTO noticeDTO=new NoticeDTO();
		noticeDTO=noticeService.noticeView(num);
		noticeService.hitUpdate(true, num);
		model.addAttribute("dto", noticeDTO);
		return "notice/noticeView";
	}
	
	@RequestMapping(value="noticeWrite", method=RequestMethod.GET)
	public void noticeWrite(){
		
	}
	
	@RequestMapping(value="noticeWrite", method=RequestMethod.POST)
	public String noticeWrite(NoticeDTO noticeDTO, HttpSession session) throws Exception{
		int result=0;
		result=noticeService.noticeInsert(noticeDTO);
		
		return "redirect:/notice/noticeList";
	}
	
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
