package com.moco.finalProject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

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
@RequestMapping
public class NoticeController {

	@Inject
	private NoticeService noticeService;
	
	@RequestMapping(value="/notice/noticeDelete", method=RequestMethod.GET)
	public String noticeDelete(int num) throws Exception{
		noticeService.noticeDelete(num);
		return "redirect:../";
	}
	
	@RequestMapping(value="/notice/noticeUpdate", method=RequestMethod.GET)
	public String noticeUpdate(int num, Model model) throws Exception{
		model.addAttribute("dto", noticeService.noticeView(num));
		return "notice/noticeUpdate";
	}
	
	@RequestMapping(value="/notice/noticeUpdate", method=RequestMethod.POST)
	public String noticeUpdate(NoticeDTO noticeDTO, HttpSession session) throws Exception{
		noticeService.noticeUpdate(noticeDTO);
		
		return "redirect:../";
	}
	
	@RequestMapping(value="/notice/noticeView", method=RequestMethod.GET)
	public String noticeView(int num, Model model) throws Exception{
		NoticeDTO noticeDTO=new NoticeDTO();
		noticeDTO=noticeService.noticeView(num);
		noticeService.hitUpdate(true, num);
		model.addAttribute("dto", noticeDTO);
		return "notice/noticeView";
	}
	
	@RequestMapping(value="/notice/noticeWrite", method=RequestMethod.GET)
	public void noticeWrite(){
		
	}
	
	@RequestMapping(value="/notice/noticeWrite", method=RequestMethod.POST)
	public String noticeWrite(NoticeDTO noticeDTO, HttpSession session) throws Exception{
		noticeService.noticeInsert(noticeDTO);
		
		return "redirect:../";
	}

}
