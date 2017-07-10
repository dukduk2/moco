package com.moco.finalProject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moco.member.MemberDTO;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.BasicMovieService;
import com.moco.notice.NoticeDTO;
import com.moco.notice.NoticeService;
import com.moco.paidMovie.PaidMovieDTO;
import com.moco.paidMovie.PaidMovieService;
import com.moco.pay.PayService;
import com.moco.review.ReviewDTO;
import com.moco.review.ReviewService;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	PaidMovieService paidMovieService;
	@Inject
	PayService payService;
	@Inject
	BasicMovieService basicMovieService;
	@Inject
	NoticeService noticeService;
	@Inject
<<<<<<< HEAD
	ReviewService reviewService;
=======
	MemberService memberService;
>>>>>>> 3f0f4275646294da95e81955ab5c485d52f547d5
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Integer curPage, Integer perPage, Locale locale, Model model, HttpSession session) throws Exception{
		Map<String, Object> map=new HashMap<String, Object>();
		//String name=((MemberDTO)session.getAttribute("memberDTO")).getName();
		
		if(curPage==null){
			curPage=1;
		}
		if(perPage==null){
			perPage=10;
		}
		map.put("curPage", curPage);
		map.put("perPage", perPage);
		
		RowMaker rowMaker=new RowMaker();
		rowMaker.makeRow(curPage, perPage);
		
		map.put("startRow", rowMaker.getStartRow());
		map.put("lastRow", rowMaker.getLastRow());
		
		PageMaker pageMaker=new PageMaker(curPage, perPage);
		int totalCount=noticeService.totalCount();
		PageResult pageResult=pageMaker.paging(totalCount);
		List<NoticeDTO> ar=noticeService.noticeList(map);
		
		model.addAttribute("map", map);
		model.addAttribute("pageResult", pageResult);
		model.addAttribute("list", ar);
		
		return "home";
		//model.addAttribute("totalCount", totalCount);
		/*logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";*/
	}
	
	@RequestMapping(value = "/user/userHome", method = RequestMethod.GET)
	public void userHome(){
		
	}
	
	@RequestMapping(value = "/movie/movieHome", method = RequestMethod.GET)
	public void movieHome(Model model){
		List<PaidMovieDTO> basicPaidList = new ArrayList<PaidMovieDTO>();
		List<PaidMovieDTO> lowPaidList = new ArrayList<PaidMovieDTO>();
		List<BasicMovieDTO> basicInfoList = new ArrayList<BasicMovieDTO>();
		List<BasicMovieDTO> lowInfoList = new ArrayList<BasicMovieDTO>();
		List<Map<String, Object>> reviewList = new ArrayList<Map<String,Object>>();
		try {
			// 유료 영화 리스트
			basicPaidList = paidMovieService.basicMovieList();
			lowPaidList = paidMovieService.lowMovieList();
			for(PaidMovieDTO dto:basicPaidList){
				BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("kind", "basic");
				map.put("num", dto.getbNum());
				basicMovieDTO = basicMovieService.view(map);
				basicInfoList.add(basicMovieDTO);
			}
			for(PaidMovieDTO dto:lowPaidList){
				BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("kind", "low");
				map.put("num", dto.getlNum());
				basicMovieDTO = basicMovieService.view(map);
				lowInfoList.add(basicMovieDTO);
			}
			// 후기 리스트
			List<ReviewDTO> list = reviewService.orderByLikeReview();
			for(ReviewDTO dto:list){
				Map<String, Object> map = new HashMap<String, Object>();
				Map<String, Object> view_map = new HashMap<String, Object>();
				BasicMovieDTO bMovieDTO = new BasicMovieDTO();
				if(dto.getlNum()==0){
					view_map.put("kind", "basic");
					view_map.put("num", dto.getbNum());
				}else{
					view_map.put("kind", "low");
					view_map.put("num", dto.getlNum());
				}
				bMovieDTO = basicMovieService.view(view_map);
				System.out.println(bMovieDTO.getTitle());
				
				map.put("movieInfo", bMovieDTO);
				map.put("reviewInfo", dto);
				reviewList.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("basicInfoList", basicInfoList).addAttribute("lowInfoList", lowInfoList)
		.addAttribute("reviewList", reviewList);
	}
<<<<<<< HEAD
	
	@RequestMapping(value="/movie/moviePlay", method=RequestMethod.GET)
	public void moviePlay(int num, Model model) throws Exception{
		PaidMovieDTO paidMovieDTO=new PaidMovieDTO();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("kind", "basic");
		map.put("num", num);
		
		paidMovieDTO=paidMovieService.paidMovieSelectOne(map);

		model.addAttribute("dto", paidMovieDTO);
	}
	
	@RequestMapping(value="/movie/payMovie", method=RequestMethod.GET)
	public void payMovie(int num, Model model, HttpSession session) throws Exception{
		Map<String, Object> basic_map=new HashMap<String, Object>(); //basicMovie
		//String id=((MemberDTO)session.getAttribute("memberDTO")).getId();
		
		System.out.println("paymovie num"+num);
		basic_map.put("num", num);
		basic_map.put("kind", "basic");

		PaidMovieDTO paidMovieDTO=new PaidMovieDTO();
		paidMovieDTO=paidMovieService.paidMovieSelectOne(basic_map);
		int myPoint=((MemberDTO)session.getAttribute("memberDTO")).getPoint();
		int price=paidMovieDTO.getPrice();
		
		System.out.println("myPoint"+myPoint);
		System.out.println("price"+price);
		
		model.addAttribute("myPoint", myPoint);
		model.addAttribute("price", price);
		model.addAttribute("dto", basicMovieService.view(basic_map));
		
	}
	
	@RequestMapping(value="/movie/payMovie", method=RequestMethod.POST)
	public String payMovie(BasicMovieDTO basicMovieDTO, int num, HttpSession session) throws Exception{		
		Map<String, Object> pay_map=new HashMap<String, Object>(); //pay
		Map<String, Object> basic_map=new HashMap<String, Object>(); //basicMovie
		//String id=((MemberDTO)session.getAttribute("memberDTO")).getId();
		
		System.out.println("paymovie num"+num);
		basic_map.put("num", num);
		basic_map.put("kind", "basic");

		PaidMovieDTO paidMovieDTO=new PaidMovieDTO();
		paidMovieDTO=paidMovieService.paidMovieSelectOne(basic_map);
		int myPoint=((MemberDTO)session.getAttribute("memberDTO")).getPoint();
		int price=paidMovieDTO.getPrice();
		
		System.out.println(num);
		
		String id=((MemberDTO)session.getAttribute("memberDTO")).getId();
	
		if(price<=myPoint){
			pay_map.put("id", id);
			pay_map.put("kind", "basic");
			pay_map.put("num", num);
		
			payService.payInsert(pay_map);
		}
		
		return "redirect:basicMovieSearch/movieSearchHome";
		
	}
=======
>>>>>>> 3f0f4275646294da95e81955ab5c485d52f547d5
}
