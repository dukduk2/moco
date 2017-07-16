package com.moco.finalProject;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.moco.fileTest.FileSaver;
import com.moco.jjim.JjimDTO;
import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.lowpricemovie.LowPriceMovieService;
import com.moco.member.MemberDTO;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.BasicMovieService;
import com.moco.movieAPI.movieSearch.SearchDTO;
import com.moco.movieRequest.MovieRequestDTO;
import com.moco.movieRequest.MovieRequestService;
import com.moco.multiplex.MultiplexDTO;
import com.moco.paidMovie.PaidMovieDTO;
import com.moco.paidMovie.PaidMovieService;
import com.moco.pay.PayDTO;
import com.moco.pay.PayService;
import com.moco.reservation.ReservationDTO;
import com.moco.screen.ScreenDTO;
import com.moco.theater.TheaterDTO;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Controller
@RequestMapping(value="/movie/lowpricemovie/**")
public class LowPriceMovieController {

	@Autowired
	private LowPriceMovieService lowPriceMovieService;
	@Inject
	BasicMovieService basicMovieService;
	@Inject
	MovieRequestService movieRequestService;
	@Inject
	PaidMovieService paidMovieService;
	@Inject
	PayService payService;

	// SEARCH HOME
	@RequestMapping(value = "movieSearchHome", method = RequestMethod.GET)
	public void movieSearchHome(Model model){
		List<String> nationList = new ArrayList<String>();
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("kind", "low");
			nationList = basicMovieService.nationList(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("nationList", nationList);
	}

	// SEARCH & LIST
	@RequestMapping(value = "movieSearch", method = RequestMethod.POST)
	public String movieSearch(SearchDTO searchDTO, Integer curPage, Model model, HttpSession session){
		List<BasicMovieDTO> movieList = new ArrayList<BasicMovieDTO>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kind", "low");
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

	//MOVIE LIST
	@RequestMapping(value="lowpricemovieList", method=RequestMethod.GET)
	public String list(Integer curPage, Integer perPage, String kind, String search, Model model) throws Exception{
		if(curPage == null){
			curPage = 1;
		}
		if(perPage == null){
			perPage = 9;
		}
		if(kind == null){
			kind = "%";
		}
		if(search == null){
			search = "%";
		}

		Map<String, Object> map = lowPriceMovieService.list(curPage, perPage, kind, search);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("pageResult", map.get("pageResult"));
		model.addAttribute("curPage", curPage);
		model.addAttribute("kind", kind);
		model.addAttribute("search", search);

		return "movie/lowpricemovie/lowpricemovieList";

	}
	/* 여기부터 VIEW */
	@RequestMapping(value = "movieView", method = RequestMethod.GET)
	public String movieView(int num, String kind, Model model, HttpSession session){
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
			Map<String, Object> view_map = new HashMap<String, Object>();
			view_map.put("num", num);
			view_map.put("kind", "low");
			basicMovieDTO = basicMovieService.view(view_map);

			Map<String, Object> jjim_map = new HashMap<String, Object>();
			jjim_map.put("kind", "low");
			jjim_map.put("id", ((MemberDTO)session.getAttribute("memberDTO")).getId());
			jjim_map.put("num", num);
			jjimDTO = basicMovieService.jjimCheck(jjim_map);
			review_count = basicMovieService.reviewCount(jjim_map);
			
			ar=payService.paySelectList();
			
			for(int i=0;i<ar.size();i++){
				if(ar.get(i).getId().equals(((MemberDTO)session.getAttribute("memberDTO")).getId()) && ar.get(i).getLnum()==num){
					model.addAttribute("payCheck", "check");
				}
			}
			
			// 신청하기, 보러가기, 접수중
			Map<String, Object> check_map = new HashMap<String, Object>();
			check_map.put("kind", "low");
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

		}
		model.addAttribute("movieDTO", basicMovieDTO).addAttribute("kind", kind).addAttribute("jjimDTO", jjimDTO)
		.addAttribute("review_count", review_count).addAttribute("movieKind", "low");

		return "movie/basicMovieSearch/movieView";
	}
	// view_story
	@RequestMapping(value = "movieView_story", method = RequestMethod.GET)
	public String movieViewStroy(int num, Model model){
		BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
		try {
			Map<String, Object> view_map = new HashMap<String, Object>();
			view_map.put("num", num);
			view_map.put("kind", "low");
			basicMovieDTO = basicMovieService.view(view_map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("movieDTO", basicMovieDTO);
		return "movie/basicMovieSearch/movieView_story";
	}
	// view_trailer
	@RequestMapping(value = "movieView_trailer", method = RequestMethod.GET)
	public String movieViewTrailer(int num, Model model){
		BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
		try {
			Map<String, Object> view_map = new HashMap<String, Object>();
			view_map.put("num", num);
			view_map.put("kind", "low");
			basicMovieDTO = basicMovieService.view(view_map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("movieDTO", basicMovieDTO);
		return "movie/basicMovieSearch/movieView_trailer";
	}

	/* 여기까지 VIEW */

	// 찜하기
	@RequestMapping(value = "jjim", method = RequestMethod.GET)
	public void jjim(boolean flag, int num, HttpSession session){
		Map<String, Object> jjim_map = new HashMap<String, Object>();
		jjim_map.put("kind", "low");
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
		map.put("kind", "low");
		map.put("num", num);
		try {
			movieRequestService.movieRequestInsert(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 영화 삭제하기
	@RequestMapping(value = "movieDelete", method = RequestMethod.GET)
	public String movieDelete(int num){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kind", "low");
		map.put("num", num);
		try {
			basicMovieService.movieInfoDelete(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:movie/lowpricemovie/movieSearchHome";
	}

	//MOVIE VIEW
	@RequestMapping(value="lowpricemovieView", method=RequestMethod.GET)
	public String view(int num, Model model) throws Exception {
		LowPriceMovieDTO lowPriceMovieDTO = lowPriceMovieService.view(num);
		model.addAttribute("lowpricemovie", lowPriceMovieDTO);
		/*	model.addAttribute("screen", map.get("screen"));*/
		return "movie/lowpricemovie/lowpricemovieView";
	}

	//MOVIE DELETE

	@RequestMapping(value="lowpricemovieDelete", method=RequestMethod.GET)
	public String delete(int num) throws Exception{
		int result = lowPriceMovieService.delete(num);

		return "redirect:/movie/lowpricemovie/lowpricemovieList";
	}

	//movie write

	@RequestMapping(value="lowpricemovieInsert", method=RequestMethod.GET)
	public String write(Model model) throws Exception{
		model.addAttribute("state", "Insert");
		return "/movie/lowpricemovie/lowpricemovieWrite";
	}

	@RequestMapping(value="lowpricemovieInsert", method=RequestMethod.POST)
	public String insert(LowPriceMovieDTO lowPriceMovieDTO, MultipartFile f1, HttpSession session, Model model) throws Exception{
		String path = session.getServletContext().getRealPath("resources/upload/lowpricemovie");

		FileSaver fileSaver = new FileSaver();

		lowPriceMovieDTO.setThumnail(fileSaver.saver(f1, path));

		int result = lowPriceMovieService.insert(lowPriceMovieDTO);
		return "redirect:/movie/lowpricemovie/lowpricemovieList";
	}
	@RequestMapping(value="lowpricemovieUpdate", method=RequestMethod.GET)
	public String update(int num, Model model) throws Exception{
		LowPriceMovieDTO lowPriceMovieDTO = lowPriceMovieService.view(num);
		model.addAttribute("lowpricemovie", lowPriceMovieDTO);
		model.addAttribute("state", "Update");
		return "movie/lowpricemovie/lowpricemovieWrite";
	}

	@RequestMapping(value="lowpricemovieUpdate", method=RequestMethod.POST)
	public String update(LowPriceMovieDTO lowPriceMovieDTO, Model model) throws Exception{

		int result = lowPriceMovieService.update(lowPriceMovieDTO);
		System.out.println(result);
		return "redirect:/movie/lowpricemovie/lowpricemovieList";
	}

	@RequestMapping(value="multiplexList_ajax", method=RequestMethod.POST)
	public void multiplexList(int theater_num, Model model) throws Exception{
		List<MultiplexDTO> ar =lowPriceMovieService.multiplexList(theater_num);

		model.addAttribute("list", ar);

	}


	@RequestMapping(value="theaterRequest", method=RequestMethod.GET)
	public void theaterRequest() throws Exception{

	}

	//상영관 등록신청
	@RequestMapping(value="theaterRequest", method=RequestMethod.POST)
	public String theaterRequest(TheaterDTO theaterDTO, MultiplexDTO multiplexDTO, String detailLocation, String multi_name) throws Exception {

		theaterDTO.setLocation(theaterDTO.getLocation()+" "+detailLocation);
		multiplexDTO.setName(multi_name);

		int result = lowPriceMovieService.theaterRequest(theaterDTO, multiplexDTO);

		System.out.println(result);

		return "redirect:/";
	}


	@RequestMapping(value="theaterInsert", method=RequestMethod.GET)
	public void insert(Integer curPage, Integer perPage, int num, Model model) throws Exception{
		if(curPage == null){
			curPage = 1;
		}
		if(perPage == null){
			perPage = 10;
		}
		model.addAttribute("lowpricemovie", lowPriceMovieService.view(num));
		Map<String, Object> map = lowPriceMovieService.theaterList(curPage, perPage, "%", "%");
		model.addAttribute("list", map.get("list"));
	}
	//영화 상영관 등록신청
	@RequestMapping(value="theaterInsert", method=RequestMethod.POST)
	public String insert(Integer movie_num, Integer[] multi_num, Date[] start_date, Date[] end_date, Model model) throws Exception{
		System.out.println("movie_num : "+movie_num);
		System.out.println("multi_num : "+multi_num);
		System.out.println("start_date : "+start_date);
		System.out.println("last_date : "+end_date);
		System.out.println("=========================");

		for(int i=0; i<multi_num.length ; i++){
			System.out.println(multi_num[i]);
			System.out.println(start_date[i]);
			System.out.println(end_date[i]);
		}
		lowPriceMovieService.theaterInsert(movie_num, multi_num, start_date, end_date);


		return "redirect:/movie/movieHome";
	}

	//상영관 리스트
	@RequestMapping(value="theaterList", method=RequestMethod.GET)
	public String theaterList(Integer curPage, Integer perPage, String kind, String search, Model model) throws Exception{
		if(curPage == null){
			curPage = 1;
		}
		if(perPage == null){
			perPage = 10;
		}
		if(kind == null){
			kind="%";
		}
		if(search == null){
			search="%";
		}
		Map<String, Object> map = lowPriceMovieService.theaterList(curPage, perPage, kind, search);

		model.addAttribute("list", map.get("list"));
		model.addAttribute("pageResult", map.get("pageResult"));
		model.addAttribute("curPage", curPage);
		model.addAttribute("kind", kind);
		model.addAttribute("search", search);

		return "movie/lowpricemovie/theaterList";	
	}


	//상영관 정보
	//상영정보(영화, 상영시작, 상영종료)까지 뿌려줘야함
	//그래서 거기서 영화 누르면 영화정보로 갈수 있게끔.
	@RequestMapping(value="theaterView", method=RequestMethod.GET)
	public String theaterView(int num, Model model) throws Exception{
		TheaterDTO theaterDTO = lowPriceMovieService.theaterView(num);
		List<MultiplexDTO> ar = lowPriceMovieService.multiplexList(num);

		model.addAttribute("theater", theaterDTO);
		model.addAttribute("multiplexList", ar);
		return "movie/lowpricemovie/theaterView";
	}
	@RequestMapping(value="screen_ajax", method=RequestMethod.POST)
	public void screenAdd(int multi_num, Model model) throws Exception{
		List<ScreenDTO> ar = lowPriceMovieService.screenList(multi_num);
		
		int lNum = 0; 

		List<String> dates = null;
		List<String> hours = null;
		List<String> minutes = null;
		
		if(ar.size() != 0){
			lNum = ar.get(0).getMovie_num();
			
			dates = new ArrayList<String>();
			hours = new ArrayList<String>();
			minutes = new ArrayList<String>();
			
			for(int i=0; i<ar.size() ; i++){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				dates.add(sdf.format(ar.get(i).getShow_date()));
	
				if(0<=ar.get(i).getHour() && ar.get(i).getHour()<10){
					hours.add("0"+ar.get(i).getHour());
				}else{
					hours.add(ar.get(i).getHour()+"");
				}
	
				if(0<=ar.get(i).getMinute() && ar.get(i).getMinute()<10){
					minutes.add("0"+ar.get(i).getMinute());
				}else{
					minutes.add(ar.get(i).getMinute()+"");
				}
			}
			model.addAttribute("screenList", ar);
			model.addAttribute("date", dates);
			model.addAttribute("hour", hours);
			model.addAttribute("minute", minutes);
			model.addAttribute("lowpricemovie", lowPriceMovieService.view(lNum));
		}
		
		model.addAttribute("size", ar.size());
	}
	
	@RequestMapping(value="reservationInsert", method=RequestMethod.POST)
	public String reservationInsert(ReservationDTO reservationDTO, HttpSession session) throws Exception{
		
		int result = 0;
		//프로시저 사용.(reservation db insert & screen db update & member db update & pay db insert)
		result = lowPriceMovieService.reservationInsert(reservationDTO);
		
		if(result > 0){
			MemberDTO memberDTO = lowPriceMovieService.memberView(reservationDTO.getId());
			session.setAttribute("memberDTO", memberDTO);
		}
		return "movie/movieHome";
		
	}
	//상영관 삭제(관리자)
	@RequestMapping(value="theaterDelete", method=RequestMethod.GET)
	public String theaterDelete(int num) throws Exception{
		//극장, 상영관, 상영영화정보 삭제.
		lowPriceMovieService.theaterDelete(num);
		return "redirect:movie/lowpricemovie/theaterList";
	}
	

}
