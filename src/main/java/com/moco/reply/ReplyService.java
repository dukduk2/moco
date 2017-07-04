package com.moco.reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.util.RowMaker;

@Service
public class ReplyService {

	@Autowired
	private ReplyDAO replyDAO;
	
	// dtoSet
	public ReplyDTO dtoSet(ReplyDTO replyDTO,String boardKind, int boardNum){
		if(boardKind.equals("userBoard")){
			replyDTO.setUnum(boardNum);
			replyDTO.setAnum(0);
		}else{
			replyDTO.setAnum(boardNum);
			replyDTO.setUnum(0);
		}
		return replyDTO;
	}
	
	// replySelectList
	public List<ReplyDTO> replySelectList(Integer curPage, Integer perPage, String boardKind, int boardNum) throws Exception{
		if(curPage == null){
			curPage = 1;
		}
		if(perPage == null){
			perPage = 5;
		}
		Map<String, Object> map = new HashMap<String, Object>();
		RowMaker rowMaker = new RowMaker();
		rowMaker.makeRow(curPage, perPage);
		map.put("row", rowMaker);
		
		if(boardKind.equals("userBoard")){
			map.put("unum", boardNum);
			map.put("anum", 0);
		}else {
			map.put("anum", boardNum);
			map.put("unum", 0);
		}
		
		return replyDAO.replySelectList(map);
	}
	// replyTotalCount
	public int replyTotalCount(ReplyDTO replyDTO) throws Exception{
		return replyDAO.replyTotalCount(replyDTO);
	}
	// replySelectOne
	public ReplyDTO replySelectOne(int num) throws Exception{
		return replyDAO.replySelectOne(num);
	}
	// replyInsert
	public int replyInsert(ReplyDTO replyDTO) throws Exception{
		return replyDAO.replyInsert(replyDTO);
	}
	// replyUpdate
	public int replyUpdate(ReplyDTO replyDTO) throws Exception{
		return replyDAO.replyUpdate(replyDTO);
	}
	// replyDelete
	public int replyDelete(int num) throws Exception{
		return replyDAO.replyDelete(num);
	}
	// replyDelete2
	public int replyDelete2(Map<String, Object> map) throws Exception{
		return replyDAO.replyDelete2(map);
	}

}
