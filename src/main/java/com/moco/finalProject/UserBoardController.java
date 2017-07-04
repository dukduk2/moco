package com.moco.finalProject;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.moco.board.BoardDTO;
import com.moco.fileTest.FileSaver;
import com.moco.likes.LikesDTO;
import com.moco.member.MemberDTO;
import com.moco.reply.ReplyService;
import com.moco.season.SeasonDTO;
import com.moco.season.SeasonService;
import com.moco.userBoard.UserBoardDTO;
import com.moco.userBoard.UserBoardService;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Controller
@RequestMapping(value="user/userBoard/")
public class UserBoardController {

	@Autowired
	private UserBoardService userBoardService;
	@Autowired
	private SeasonService seasonService;
	
	@RequestMapping(value="userBoardList", method=RequestMethod.GET)
	public void list(String season, Integer curPage, Integer perPage, String kind, String search, Model model) throws Exception{
		if(season == null){
			season = "%";
		}
		if(season.equals("all")){
			season = "%";
		}
		if(curPage == null){
			curPage = 1;
		}
		if(perPage == null){
			perPage = 10;
		}
		if(kind == null){
			kind = "title";
		}
		if(search == null){
			search = "%";
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("perPage", perPage);
		map.put("curPage", curPage);
		map.put("season", season);
		map.put("kind", kind);
		map.put("search", search);
		
		RowMaker rowMaker = new RowMaker();
		rowMaker.makeRow(curPage, perPage);
		
		map.put("startRow", rowMaker.getStartRow());
		map.put("lastRow", rowMaker.getLastRow());
		
		model.addAttribute("map", map);
		model.addAttribute("pageResult", userBoardService.pageing(curPage, map));
		model.addAttribute("list", userBoardService.list(map));
		// 관리자가 order(회차) 를 내리면 db에서 읽어온다.
		model.addAttribute("orderList", seasonService.adminOrderSelect("user"));
		
		// 글을 쓸 수 있는 상태인지 check값을 model에 담아서 전송
		SeasonDTO seasonDTO = seasonService.adminOrderCheck("user");
		if(seasonDTO != null){
			model.addAttribute("seasonCheck", true);
		}else{
			model.addAttribute("seasonCheck", false);
		}
		
	}
	
	@RequestMapping(value="userBoardView", method=RequestMethod.GET)
	public void boardView(HttpSession session, int num, int commit, Model model) throws Exception{
		// DTO 반환
		UserBoardDTO userBoardDTO = (UserBoardDTO)userBoardService.view(num);
		model.addAttribute("UserBoardDTO", userBoardDTO);
		
		// 현재 session에서 memberDTO을 꺼내서 Likes를 검사하자
		boolean check = false;
		MemberDTO memberDTO = (MemberDTO)session.getAttribute("memberDTO");
		// likesDTO 를 보내므로 LikesDTO를 셋팅
		LikesDTO likesDTO = new LikesDTO();
		likesDTO.setId(memberDTO.getId());
		likesDTO.setUnum(userBoardDTO.getNum());
		// 최종적으로 likesCheck를 하고 check값에 따라 메세지를 model에 담아서 보낸다.
		check = userBoardService.likesCheck(likesDTO);
		if(check){ // '좋아요' 상태 >> 좋아요 취소
			model.addAttribute("message", true);
		}else { // '좋아요' 하지 않은 상태 >> 좋아요
			model.addAttribute("message", false);
		}
		model.addAttribute("likesResult", userBoardService.boardLikesCount(userBoardDTO.getNum()));
	}
	
	@RequestMapping(value="userBoardLikes", method=RequestMethod.POST)
	public String likesClick(String id, int unum, Model model) throws Exception{
		boolean check = false;
		LikesDTO likesDTO = new LikesDTO();
		likesDTO.setId(id);
		likesDTO.setUnum(unum);
		// 체크
		check = userBoardService.likesCheck(likesDTO);
		if(check){ // '좋아요' 상태 >> 좋아요 취소
			userBoardService.likesDelete(likesDTO);
			model.addAttribute("message", false);
		}else { // '좋아요' 하지 않은 상태 >> 좋아요
			userBoardService.likesInsert(likesDTO);
			model.addAttribute("message", true);
		}
		// boardLikesCount AJAX 
		model.addAttribute("likesResult", userBoardService.boardLikesCount(unum));
		
		return "user/userBoard/userBoardLikesResult";
	}
	
	@RequestMapping (value="userBoardWrite", method=RequestMethod.GET)
	public void boardWrite(Model model) throws Exception{
		// 관리자가 order(회차) 를 내리면 db에서 읽어온다.
		SeasonDTO seasonDTO = seasonService.adminOrderSelectOne("user");
		model.addAttribute("order", seasonDTO);
	}
	
	@RequestMapping(value="userBoardWrite", method=RequestMethod.POST)
	public String boardWrite(UserBoardDTO userBoardDTO, @RequestParam(value="file") MultipartFile multipartFile, HttpSession session){
		// 파일 업로드
		String path = session.getServletContext().getRealPath("resources/upload/userBoard");
		FileSaver fileSaver = new FileSaver();
		userBoardDTO.setOname(multipartFile.getOriginalFilename());
		try {
			userBoardDTO.setFname(fileSaver.saver(multipartFile, path));
			String str = userBoardDTO.getFname().substring(userBoardDTO.getFname().lastIndexOf("_"));
			int fileCheck = str.length();
			// 파일을 올리지 않고 글쓰기를 하였을 때
			if(fileCheck == 1){
				fileSaver.fileDelete(path, userBoardDTO.getFname());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 글 등록
		int result = 0;
		try {
			result = userBoardService.write(userBoardDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/user/userBoard/userBoardList?season=all";
	}
	
	@RequestMapping(value="userBoardDelete", method=RequestMethod.GET)
	public String userBoardDelete(int num, HttpSession session) throws Exception{
		userBoardService.delete(num, session); 
		return "redirect:/user/userBoard/userBoardList?season=all";
	}
	
}
