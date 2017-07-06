package com.moco.finalProject;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moco.reply.ReplyDTO;
import com.moco.reply.ReplyService;

@Controller
@RequestMapping(value="user/reply/")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	public void forList(Integer curPage, Integer perPage, String boardKind, int boardNum, Model model) throws Exception{
		// list
		List<ReplyDTO> ar = replyService.replySelectList(curPage, perPage, boardKind, boardNum);
		// Ajax 포워딩
		model.addAttribute("ReplyList", ar);
		model.addAttribute("size", ar.size());
		model.addAttribute("max", perPage-1);
		
	}
	
	@RequestMapping(value="replyList", method=RequestMethod.POST)
	public String replyList(Integer curPage, Integer perPage, String boardKind, int boardNum, Model model) throws Exception{				
		
		this.forList(curPage, perPage, boardKind, boardNum, model);
		
		return "user/reply/replyResult";
	}
	
	@RequestMapping(value="replyInsert", method=RequestMethod.POST)
	public String replyInsert(Integer curPage, Integer perPage, ReplyDTO replyDTO, String boardKind, int boardNum, Model model) throws Exception{
		// insert를 위해 필요한 정보를 ReplyDTO에 셋팅
		replyDTO = replyService.dtoSet(replyDTO, boardKind, boardNum);
		// insert
		replyService.replyInsert(replyDTO);
		// list
		this.forList(curPage, perPage, boardKind, boardNum, model);
		
		return "user/reply/replyResult";
	}
	
	@RequestMapping(value="replyDelete", method=RequestMethod.POST)
	public String replyDelete(Integer curPage, String boardKind, int boardNum, int perPage, int num, Model model) throws Exception{
		// pk로 삭제
		replyService.replyDelete(num);
		// list
		this.forList(curPage, perPage, boardKind, boardNum, model);
		
		return "user/reply/replyResult";
	}
	
	@RequestMapping(value="replyUpdate", method=RequestMethod.GET)
	public String replyUpdate(Integer curPage, Integer perPage, String boardKind, int boardNum, int num, Model model) throws Exception{
		// form 띄워주기 - 하나 읽어오기
		ReplyDTO replyDTO = replyService.replySelectOne(num);
		model.addAttribute("replyDTO", replyDTO);
		// list
		this.forList(curPage, perPage, boardKind, boardNum, model);
		
		return "user/reply/replyResult";
	}
	
	@RequestMapping(value="replyUpdate", method=RequestMethod.POST)
	public String replyUpdate(Integer curPage, String boardKind, int boardNum, int perPage, int num, Model model, ReplyDTO replyDTO) throws Exception{
		// dto 셋팅
		replyDTO = replyService.dtoSet(replyDTO, boardKind, boardNum);
		// update
		replyService.replyUpdate(replyDTO);
		// list
		this.forList(curPage, perPage, boardKind, boardNum, model);
		model.addAttribute("replyDTO", null);
		
		return "user/reply/replyResult";
	}
	
}
