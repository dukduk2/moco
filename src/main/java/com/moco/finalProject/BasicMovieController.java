package com.moco.finalProject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moco.jjim.JjimDTO;
import com.moco.member.MemberDTO;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.BasicMovieService;
import com.moco.movieAPI.movieSearch.SearchDTO;
import com.moco.movieRequest.MovieRequestDTO;
import com.moco.movieRequest.MovieRequestService;
import com.moco.paidMovie.PaidMovieDTO;
import com.moco.paidMovie.PaidMovieService;
import com.moco.pay.PayDTO;
import com.moco.pay.PayService;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Controller
@RequestMapping(value="/movie/basicMovieSearch/")
public class BasicMovieController {
	@Inject
	BasicMovieService basicMovieService;
	@Inject
	MovieRequestService movieRequestService;
	@Inject
	PaidMovieService paidMovieService;
	@Inject
	PayService payService;

	@RequestMapping(value = "movieSearchHome", method = RequestMethod.GET)
	public void movieSearchHome(Model model){
		List<String> nationList = new ArrayList<String>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("kind", "basic");
			nationList = basicMovieService.nationList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("nationList", nationList);
	}

	@RequestMapping(value = "movieSearch", method = RequestMethod.POST)
	public String movieSearch(SearchDTO searchDTO, Integer curPage, Model model, HttpSession session){
		List<BasicMovieDTO> movieList = new ArrayList<BasicMovieDTO>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kind", "basic");
		// curPage
		if(curPage == null){
			curPage = 1;
		}
		// 입력값이 없으면 null로 초기화
		if(searchDTO.getTitle()==""){
			searchDTO.setTitle(null);
		}
		if(searchDTO.getGenre().equals("all") || searchDTO.getGenre().equals("")){
			searchDTO.setGenre(null);
		}
		if(searchDTO.getNation().equals("all") || searchDTO.getNation().equals("")){
			searchDTO.setNation(null);
		}
		if(searchDTO.getDirector()==""){
			searchDTO.setDirector(null);
		}
		if(searchDTO.getActor()==""){
			searchDTO.setActor(null);
		}
		if(searchDTO.getYearMin()==0){
			searchDTO.setYearMin(1900);
		}
		if(searchDTO.getYearMax()==0){
			searchDTO.setYearMax(2100);
		}
		// map.put
		map.put("searchDTO", searchDTO);
		map.put("curPage", curPage);
		// totalCount
		int totalCount = 0;
		try {
			totalCount = basicMovieService.totalCount(map);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		// paging
		PageMaker pageMaker = new PageMaker(curPage);
		RowMaker rowMaker = pageMaker.getRowMaker();
		PageResult pageResult = pageMaker.paging(totalCount);
		map.put("rowMaker", rowMaker);
		// list
		try {
			movieList = basicMovieService.list(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// view 이후 리스트로 돌아갈 때
		session.setAttribute("searchDTO", searchDTO);
		session.setAttribute("curPage", curPage);
		// model
		model.addAttribute("movieList", movieList).addAttribute("pageResult", pageResult).addAttribute("curPage", curPage)
		.addAttribute("searchDTO", searchDTO);
		return "movie/basicMovieSearch/movieList";
	}
	// view
	@RequestMapping(value = "movieView", method = RequestMethod.GET)
	public void movieView(int num, String kind, Model model, HttpSession session){
		if(kind==null){
			kind="story";
		}
		BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
		JjimDTO jjimDTO = null;
		int review_count = 0;
		// 신청하기, 보러가기, 접수중
		MovieRequestDTO movieRequestDTO = null;
		PaidMovieDTO paidMovieDTO = null;
		List<PayDTO> ar=new ArrayList<PayDTO>();
		PayDTO payDTO = new PayDTO(); //결제여부 확인
		try {
<<<<<<< HEAD
			Map<String, Object> view_map = new HashMap<String, Object>();
			view_map.put("num", num);
			view_map.put("kind", "basic");
			basicMovieDTO = basicMovieService.view(view_map);
			
			Map<String, Object> jjim_map = new HashMap<String, Object>();
			jjim_map.put("kind", "basic");
			jjim_map.put("id", ((MemberDTO)session.getAttribute("memberDTO")).getId());
			jjim_map.put("num", num);
			jjimDTO = basicMovieService.jjimCheck(jjim_map);
			review_count = basicMovieService.reviewCount(jjim_map);

=======
			basicMovieDTO = basicMovieService.view(num);
			JjimDTO testJjim = new JjimDTO();
			testJjim.setbNum(num);
			testJjim.setId(((MemberDTO)session.getAttribute("memberDTO")).getId());
			jjimDTO = basicMovieService.jjimCheck(testJjim);
			review_count = basicMovieService.reviewCount(num);
			
			ar=payService.paySelectList();
			
			for(int i=0;i<ar.size();i++){
				if(ar.get(i).getId().equals(((MemberDTO)session.getAttribute("memberDTO")).getId()) && ar.get(i).getBnum()==num){
					System.out.println("ok");
					model.addAttribute("payCheck", "check");
				}
			}
			
>>>>>>> 2ba19372ce694e3cf86e941704dcd4997ed08211
			// 신청하기, 보러가기, 접수중
			Map<String, Object> check_map = new HashMap<String, Object>();
			check_map.put("kind", "basic");
			check_map.put("num", num);
			paidMovieDTO = paidMovieService.paidMovieSelectOne(check_map);
			movieRequestDTO = movieRequestService.movieRequestSelectOne(check_map);
			if(paidMovieDTO != null){ // 보러가기
				model.addAttribute("requestMessage", "영화보러가기");
			}else if(paidMovieDTO == null & movieRequestDTO != null){ // 접수중
				model.addAttribute("requestMessage", "영화등록중");
			}else{ // 신청하기
				model.addAttribute("requestMessage", "영화신청하기");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("movieDTO", basicMovieDTO).addAttribute("kind", kind).addAttribute("jjimDTO", jjimDTO)
		.addAttribute("review_count", review_count);
	}
	// view_story
	@RequestMapping(value = "movieView_story", method = RequestMethod.GET)
	public void movieViewStroy(int num, Model model){
		BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
		try {
			Map<String, Object> view_map = new HashMap<String, Object>();
			view_map.put("num", num);
			view_map.put("kind", "basic");
			basicMovieDTO = basicMovieService.view(view_map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("movieDTO", basicMovieDTO);
	}
	// view_trailer
	@RequestMapping(value = "movieView_trailer", method = RequestMethod.GET)
	public void movieViewTrailer(int num, Model model){
		BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
		try {
			Map<String, Object> view_map = new HashMap<String, Object>();
			view_map.put("num", num);
			view_map.put("kind", "basic");
			basicMovieDTO = basicMovieService.view(view_map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("movieDTO", basicMovieDTO);
	}
	// 찜하기
	@RequestMapping(value = "jjim", method = RequestMethod.GET)
	public void jjim(boolean flag, int num, HttpSession session){
		Map<String, Object> jjim_map = new HashMap<String, Object>();
		jjim_map.put("kind", "basic");
		jjim_map.put("id", ((MemberDTO)session.getAttribute("memberDTO")).getId());
		jjim_map.put("num", num);
		try{
			if(flag){
				basicMovieService.jjimInsert(jjim_map);
			}else{
				basicMovieService.jjimDelete(jjim_map);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	// 영화 신청하기
	@RequestMapping(value = "movieRequest", method = RequestMethod.GET)
	public void movieRequest(int num){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kind", "basic");
		map.put("num", num);
		try {
			movieRequestService.movieRequestInsert(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/*@RequestMapping(value="../moviePlay", method=RequestMethod.GET)
	public void moviePlay(){
		
	}*/

}
