package com.moco.userBoard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.board.BoardDTO;
import com.moco.board.BoardService;
import com.moco.fileTest.FileSaver;
import com.moco.likes.LikesDTO;
import com.moco.reply.ReplyService;
import com.moco.season.SeasonDTO;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
@Service
public class UserBoardService implements BoardService {
	
	@Autowired
	private UserBoardDAO userBoardDAO;
	@Autowired
	private ReplyService replyService;
	
	// contents - parsingMethod
	public String contentsParsing(String contents) {
		String fname = "";
		// Check
		boolean check = true;
		try{
			fname = contents.substring(contents.lastIndexOf("<img"));
		}catch(Exception e){
			check = false;
		}
		if(check){
			// 	parsing
			fname = contents.substring(contents.lastIndexOf("upload/"), contents.lastIndexOf("\" "));
			fname = fname.substring(7);
			System.out.println("parsingMethod : "+fname);
		}
		return fname;
	}
	
	// 페이징
	public PageResult pageing(Integer curPage, Map<String, Object> map) throws Exception{
		PageMaker pageMaker = new PageMaker(curPage);
		int totalCount = this.totalCount(map);
		PageResult pageResult = pageMaker.paging(totalCount);
		return pageResult;
	}
	
	//////////////////////////////////////////////////// LIKES //////////////////////////////////////////////////
	// boardLikesCount 
	public int boardLikesCount(int num) throws Exception{
		return userBoardDAO.boardLikesCount(num);
	}
	// viewPage에 접근한 user가 현재 게시물에 '좋아요'를 하였는지 check
	public boolean likesCheck(LikesDTO likesDTO) throws Exception{
		return userBoardDAO.likesCheck(likesDTO);
	}
	// likesInsert >> likesTableInsert, userBoardTableUpdate
	public int likesInsert(LikesDTO likesDTO) throws Exception{
		return userBoardDAO.likesInsert(likesDTO);
	}
	// likesDelete >> likesTableDelete, userBoardTableUpdate
	public int likesDelete(LikesDTO likesDTO) throws Exception{
		return userBoardDAO.likesDelete(likesDTO);
	}
	
	/////////////////////////////////////////////////USERBOARD COMMIT & VIDEO STATE ////////////////////////////////////////////
	
	// adminIndexCount
	public int adminIndexCount() throws Exception{
		return userBoardDAO.adminIndexCount();
	}
	
	// Admin userBoardCommit Update
	public void adminCommitUpdate(int num) throws Exception{
		userBoardDAO.adminCommitUpdate(num);
	}
	
	// Admin userBoardVideoState Update
	public void adminVideoStateUpdate(int num) throws Exception{
		userBoardDAO.adminVideoStateUpdate(num);
	}
	
	// Admin adminCommitSelect
	public List<UserBoardDTO> adminCommitSelect(Map<String, Object> map) throws Exception{
		return userBoardDAO.adminCommitSelect(map);
	}
	
	// Admin adminTotalCount
	public int adminTotalCount(Map<String, Object> map) throws Exception{
		return userBoardDAO.adminTotalCount(map);
	}
	
	/////////////////////////////////////////////////USERBOARD /////////////////////////////////////////////////////////////////////
	public String userBoardContents(int num) throws Exception{
		return userBoardDAO.userBoardContents(num);
	}
	
	@Override
	public List<BoardDTO> list(Map<String, Object> map) throws Exception {
		return userBoardDAO.list(map);
	}

	@Override
	public BoardDTO view(int num) throws Exception {
		// hitUpdate
		userBoardDAO.hitUpdate(num, true);
		return userBoardDAO.view(num);
	}

	@Override
	public int write(BoardDTO boardDTO) throws Exception {
		return userBoardDAO.write(boardDTO);
	}

	@Override
	public int update(BoardDTO boardDTO) throws Exception {
		// hitUpdate
		userBoardDAO.hitUpdate(boardDTO.getNum(), false);
		return userBoardDAO.update(boardDTO);
	}

	@Override
	public int delete(int num, HttpSession session) throws Exception {
		// upload 된 파일 삭제 - upload/userBoard
		FileSaver fileSaver = new FileSaver();
		String fileName = userBoardDAO.view(num).getFname();
		String path = session.getServletContext().getRealPath("resources/upload/userBoard");
		fileSaver.fileDelete(path, fileName);
		// upload - smartEditor // contents에 사진 fname이 들어있음, 파싱해서 삭제하자
		String contents = this.userBoardContents(num);
		path = session.getServletContext().getRealPath("resources/upload");
		contents = this.contentsParsing(contents); // 파일 이름만 있는 contents 반환
		// 파싱결과가 ""이면 삭제하지 않는다.
		if(contents != ""){
			fileSaver.fileDelete(path, contents);
		}
		// reply 삭제 - unum
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("unum", num);
		map.put("anum", 0);
		replyService.replyDelete2(map);
		// 좋아요 삭제
		userBoardDAO.likesDelete2(num);
		// 게시글 삭제
		return userBoardDAO.delete(num);
	}

	@Override
	public int totalCount(Map<String, Object> map) throws Exception {
		return userBoardDAO.totalCount(map);
	}

	@Override
	public void hitUpdate(int num, boolean flag) throws Exception {
		userBoardDAO.hitUpdate(num, flag);
	}

}
