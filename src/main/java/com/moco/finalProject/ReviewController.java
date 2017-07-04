package com.moco.finalProject;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moco.member.MemberDTO;
import com.moco.review.ReviewDTO;
import com.moco.review.ReviewLikeDTO;
import com.moco.review.ReviewService;
import com.moco.util.PageResult;
import com.moco.viewCheck.ViewCheckDTO;
import com.moco.viewCheck.ViewCheckService;

@Controller
@RequestMapping(value="movie/review/")
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	@Autowired
	private ViewCheckService viewCheckService;

	// list를 위한
	public void forList(HttpSession session, Integer curPage, String boardKind, int boardNum, Model model) throws Exception{
		if(curPage == null){
			curPage = 1;
		}
		// pageing
		int perPage = 5;
		PageResult pageResult = reviewService.pageing(curPage, perPage, boardKind, boardNum);

		// viewCheck
		ViewCheckDTO viewCheckDTO = viewCheckService.viewCheckDTOSet(boardKind, boardNum, ((MemberDTO)session.getAttribute("memberDTO")).getId());
		model.addAttribute("viewCheck", viewCheckService.viewCheck(viewCheckDTO));

		// reviewCheck
		model.addAttribute("reviewCheck", reviewService.reviewCheck(session, boardKind, boardNum));

		// list 불러오기
		List<ReviewDTO> ar = reviewService.reviewSelectList(curPage, boardKind, boardNum);
		model.addAttribute("reviewList", ar);
		model.addAttribute("pageResult", pageResult);

		// totalCount
		model.addAttribute("totalCount", reviewService.reviewTotalCount(reviewService.reviewDTOSet(boardKind, boardNum)));

	}
	
	// likes
	@RequestMapping(value="reviewLikesInsert", method=RequestMethod.POST)
	public String reviewLikesInsert(HttpSession session, Model model, String boardKind, int boardNum, Integer curPage, ReviewLikeDTO reviewLikeDTO) throws Exception{
		// check
		boolean check = reviewService.reviewLikesCheck(reviewLikeDTO);
		// insert
		if(check){
			reviewService.reviewLikesInsert(reviewLikeDTO);
			model.addAttribute("message", "'좋아요'");
		}else{
			model.addAttribute("message", "'좋아요'는 한번만 누르실 수 있습니다. ");
		}
		
		this.forList(session, curPage, boardKind, boardNum, model);
		
		return "movie/review/reviewResult"; 
	}
	
	// viewCheck
	@RequestMapping(value="viewCheckClick", method=RequestMethod.POST)
	public String viewCheckClick(HttpSession session, ViewCheckDTO viewCheckDTO, String boardKind, int boardNum, Model model) throws Exception{
		// DTO 셋팅
		viewCheckDTO = viewCheckService.viewCheckDTOSet(boardKind, boardNum, viewCheckDTO.getId());

		this.forList(session, 1, boardKind, boardNum, model);

		// viewCheckInsert
		viewCheckService.viewCheckInsert(viewCheckDTO);
		model.addAttribute("viewCheck", viewCheckService.viewCheck(viewCheckDTO));

		return "movie/review/reviewResult"; 
	}

	// list
	@RequestMapping(value="reviewList", method=RequestMethod.POST)
	public String reviewSelectList(HttpSession session,Integer curPage, String boardKind, int boardNum, Model model) throws Exception{

		this.forList(session, curPage, boardKind, boardNum, model);

		return "movie/review/reviewResult";
	}

	// write
	@RequestMapping(value="reviewWrite", method=RequestMethod.POST)
	public String reviewWrite(HttpSession session, Integer curPage, String boardKind, int boardNum, ReviewDTO reviewDTO, Model model) throws Exception{
		// DTO 셋팅
		if(boardKind.equals("basicMovie")){
			reviewDTO.setbNum(boardNum);
			reviewDTO.setlNum(0);
		}else{
			reviewDTO.setbNum(0);
			reviewDTO.setlNum(boardNum);
		}

		// insert
		reviewService.reviewInsert(reviewDTO);

		// userRating 
		int result = reviewService.reviewUserRating(boardKind, boardNum);
		if(result>0){
			System.out.println("userRating 등록");
		}else{
			System.out.println("userRating 등록실패");
		}

		// list
		this.forList(session, curPage, boardKind, boardNum, model);

		return "movie/review/reviewResult"; 
	}

	// delete
	@RequestMapping(value="reviewDelete", method=RequestMethod.POST)
	public String reviewDelete(HttpSession session, Integer curPage, int num, String boardKind, int boardNum, Model model) throws Exception{
		// 삭제
		reviewService.reviewDelete(num);

		// userRating 
		int result = reviewService.reviewUserRating(boardKind, boardNum);
		if(result>0){
			System.out.println("userRating 등록");
		}else{
			System.out.println("userRating 등록실패");
		}

		this.forList(session, curPage, boardKind, boardNum, model);

		return "movie/review/reviewResult";
	}

	// update - get
	@RequestMapping(value="reivewUpdate", method=RequestMethod.GET)
	public String reivewUpdate(HttpSession session, Integer curPage, String boardKind, int boardNum, int num, Model model) throws Exception{
		ReviewDTO reviewDTO = reviewService.reviewSelectOne(num);
		model.addAttribute("reviewDTO", reviewDTO);

		this.forList(session, curPage, boardKind, boardNum, model);

		return "movie/review/reviewResult";
	}

	// update - post
	@RequestMapping(value="reivewUpdate", method=RequestMethod.POST)
	public String reivewUpdate(HttpSession session, Integer curPage, ReviewDTO reviewDTO, String boardKind, int boardNum, Model model) throws Exception{
		// update
		reviewService.reviewUpdate(reviewDTO);

		// userRating 
		int result = reviewService.reviewUserRating(boardKind, boardNum);
		if(result>0){
			System.out.println("userRating 등록");
		}else{
			System.out.println("userRating 등록실패");
		}

		model.addAttribute("reviewDTO", null);
		this.forList(session, curPage, boardKind, boardNum, model);

		return "movie/review/reviewResult";
	}
}
