package com.moco.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.member.MemberDTO;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Service
public class ReviewService {

	@Autowired
	private ReviewDAO reviewDAO;

	// DTO set
	public ReviewDTO reviewDTOSet(String boardKind, int boardNum) throws Exception{
		ReviewDTO reviewDTO = new ReviewDTO();
		if(boardKind.equals("basicMovie")){
			reviewDTO.setbNum(boardNum);
			reviewDTO.setlNum(0);
		}else{
			reviewDTO.setbNum(0);
			reviewDTO.setlNum(boardNum);
		}
		return reviewDTO;
	}

	// 페이징
	public PageResult pageing(Integer curPage, Integer perPage, String boardKind, int boardNum) throws Exception{
		// 페이징 처리
		PageMaker pageMaker = new PageMaker(curPage, perPage);
		// totalCount method를 호출 하기 위해서 ReviewDTO를 생성
		ReviewDTO reviewDTO = this.reviewDTOSet(boardKind, boardNum);
		int totalCount = this.reviewTotalCount(reviewDTO);
		System.out.println("ReviewService>> totalCount : "+totalCount);
		PageResult pageResult = pageMaker.paging(totalCount);
		return pageResult;
	}

	//reviewCheck
	public boolean reviewCheck(HttpSession session, String boardKind, int boardNum) throws Exception{
		// 후기를 안남겼다면 false, 남겼다면 true
		boolean check = false;
		// DTO 셋팅
		// bnum, lnum
		ReviewDTO reviewDTO = this.reviewDTOSet(boardKind, boardNum);
		// id
		String writer = ((MemberDTO)session.getAttribute("memberDTO")).getId();
		reviewDTO.setWriter(writer);

		// check!
		reviewDTO = reviewDAO.reviewCheck(reviewDTO);

		if(reviewDTO != null){
			check = !check;
		}

		return check;
	}

	// reviewSelectList
	public List<ReviewDTO> reviewSelectList(Integer curPage, String boardKind, int boardNum) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		// basicMovie인지 lowPriceMovie인지 판별
		if(boardKind.equals("basicMovie")){
			map.put("bNum", boardNum);
			map.put("lNum", 0);
		}else{
			map.put("bNum", 0);
			map.put("lNum", boardNum);
		}

		RowMaker rowMaker = new RowMaker();
		rowMaker.makeRow(curPage, 5);
		map.put("row", rowMaker);

		return reviewDAO.reviewSelectList(map);
	}
	// reviewSelectOne
	public ReviewDTO reviewSelectOne(int num) throws Exception{
		return reviewDAO.reviewSelectOne(num);
	}
	// reviewInsert
	public int reviewInsert(ReviewDTO reviewDTO) throws Exception{
		return reviewDAO.reviewInsert(reviewDTO);
	}
	// reviewUpdate
	public int reviewUpdate(ReviewDTO reviewDTO) throws Exception{
		return reviewDAO.reviewUpdate(reviewDTO);
	}
	// reviewDelete
	public int reviewDelete(int num) throws Exception{
		// review 삭제
		int result = reviewDAO.reviewDelete(num);
		// 좋아요 삭제
		result += reviewDAO.reviewDelete2(num);
		return result;
	}
	// reviewTotalCount
	public int reviewTotalCount(ReviewDTO reviewDTO) throws Exception{
		return reviewDAO.reviewTotalCount(reviewDTO);
	}

	// reviewUserRating
	public int reviewUserRating(String boardKind, int boardNum) throws Exception{
		int result = 0;
		ReviewDTO reviewDTO = this.reviewDTOSet(boardKind, boardNum);
		int human = reviewDAO.reviewHuman(reviewDTO);
		System.out.println("REviewService >리뷰 작성한 사람 수 : "+human);
		double user_rating = 0;
		List<Integer> ar = reviewDAO.reviewUserRating(reviewDTO);
		int sum = 0;
		for(int i=0;i<ar.size();i++){
			sum = sum+ar.get(i);
		}
		System.out.println("REviewService > 리뷰 누적 별점 : "+sum);
		if(sum>0){
			user_rating = (double)sum/human;			
		}
		System.out.println("ReviewService > 평균점 : "+user_rating);
		if(boardKind.equals("basicMovie")){
			result = this.basicMovieUserRating(boardNum, user_rating);
		}else{
			result = this.lowPriceMovieUserRating(boardNum, user_rating);
		}
		return result;
	}
	// basicMovieUserRating
	public int basicMovieUserRating(int num, double user_rating) throws Exception{
		BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
		basicMovieDTO.setNum(num);
		basicMovieDTO.setUser_rating(user_rating);
		return reviewDAO.basicMovieUserRating(basicMovieDTO);
	}
	// lowPriceMovieUserRating
	public int lowPriceMovieUserRating(int num, double user_rating) throws Exception{
		LowPriceMovieDTO lowPriceMovieDTO = new LowPriceMovieDTO();
		lowPriceMovieDTO.setNum(num);
		lowPriceMovieDTO.setUser_rating(user_rating);
		return reviewDAO.lowPriceMovieUserRating(lowPriceMovieDTO);
	}

	// like
	// reviewLikesCheck
	public boolean reviewLikesCheck(ReviewLikeDTO reviewLikeDTO) throws Exception{
		boolean check = true;
		// 검사해서 덮어쓰기
		reviewLikeDTO = reviewDAO.reviewLikesCheck(reviewLikeDTO);
		// 이미 있다면, false 반환
		if(reviewLikeDTO != null){
			check = !check;
		}
		return check;
	}
	// insert
	public int reviewLikesInsert(ReviewLikeDTO reviewLikeDTO) throws Exception{
		int result = 0;
		// reviewLike Table Insert
		result = reviewDAO.reviewLikesInsert(reviewLikeDTO);
		// review Table Update
		result += reviewDAO.reviewLikesInsert2(reviewLikeDTO.getrNum());
		return result;
	}

}
