package com.moco.finalProject;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import com.moco.multiplex.MultiplexDTO;
import com.moco.screen.ScreenDTO;
import com.moco.theater.TheaterDTO;

@Controller
@RequestMapping(value="/movie/lowpricemovie/**")
public class LowPriceMovieController {
	
	@Autowired
	private LowPriceMovieService lowPriceMovieService;
	
	// SEARCH HOME
	@RequestMapping(value = "lowpricemovieSearchHome", method = RequestMethod.GET)
	public void movieSearchHome(Model model){
		/*List<String> nationList = new ArrayList<String>();
		try {
			nationList = basicMovieService.nationList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("nationList", nationList);*/
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
	public void insert(int num, Model model) throws Exception{
		model.addAttribute("lowpricemovie", lowPriceMovieService.view(num));
		Map<String, Object> map = lowPriceMovieService.theaterList(1, 10, "%", "%");
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
		
		
		return "redirect:/";
	}
	
	// 찜
	@RequestMapping(value = "jjim", method = RequestMethod.GET)
	public void jjim(boolean flag, int lNum, HttpSession session){
		JjimDTO jjimDTO = new JjimDTO();
		jjimDTO.setId(((MemberDTO)session.getAttribute("memberDTO")).getId());
		jjimDTO.setlNum(lNum);
		try{
			if(flag){
				lowPriceMovieService.jjimInsert(jjimDTO);
			}else{
				lowPriceMovieService.jjimDelete(jjimDTO);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
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
		int lNum = ar.get(0).getMovie_num();

		model.addAttribute("screenList", ar);
		model.addAttribute("lowpricemovie", lowPriceMovieService.view(lNum));
	}
	/*
	//상영관 수정(관리자)
	@RequestMapping(value="theaterUpdate", method=RequestMethod.GET)
	public String theaterUpdate(int num, Model model){
		TheaterDTO theaterDTO = lowPriceMovieService.theaterView(num);
		model.addAttribute("theaterDTO", theaterDTO);
		return "movie/lowpricemovie/theaterUpdate";
	}
	@RequestMapping(value="theaterUpdate", method=RequestMethod.POST)
	public String theaterUpdate(TheaterDTO theaterDTO, String detailLocation){
		theaterDTO.setLocation(theaterDTO.getLocation()+" "+detailLocation);
		lowPriceMovieService.theaterUpdate(theaterDTO);
		return "redirect:/movie/lowpricemovie/theaterList";
	}
	
	//상영관 삭제(관리자)
	@RequestMapping(value="theaterDelete", method=RequestMethod.GET)
	public String theaterDelete(int num){
		lowPriceMovieService.theaterDelete(num);
		return "redirect:/movie/lowpricemovie/theaterList";
	}
	*/
	
}
