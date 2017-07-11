package com.moco.finalProject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moco.directorBoard.invest.InvestService;
import com.moco.member.MemberService;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.BasicMovieService;
import com.moco.movieAPI.movieRecommend.RecommendService;
import com.moco.movieAPI.movieRecommend.weather.Getweather;
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

	@Inject
	PaidMovieService paidMovieService;
	@Inject
	PayService payService;
	@Inject
	BasicMovieService basicMovieService;
	@Inject
	NoticeService noticeService;
	@Inject
	ReviewService reviewService;
	@Inject
	MemberService memberService;
	@Inject
	RecommendService recommendService;
	@Inject
	InvestService investService;

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
	}

	@RequestMapping(value = "/user/userHome", method = RequestMethod.GET)
	public void userHome(Model model) throws Exception{
		int totalInvestor = 0;
		int avgInvestMoney = 0;
		int totalCount = 0;
		int successCount = 0;
		int totalInvestMoney = 0;
		double chart = 0.0;

		try{
			totalInvestor = investService.totalInvestor();
		}catch(Exception e){
			totalInvestor = 0;
		}
		try{
			avgInvestMoney = investService.avgInvestMoney();
		}catch(Exception e){
			avgInvestMoney = 0;
		}
		try{
			totalCount = investService.totalCount();
			successCount = investService.successCount();
			chart = (successCount*1.0/totalCount*1.0)*100;
		}catch(Exception e){
			chart = 0.0;
		}
		try {
			totalInvestMoney = investService.totalInvestMoney()/10000;
		} catch (Exception e) {
			totalInvestMoney = 0;
		}
		
		model.addAttribute("totalInvestor", totalInvestor).addAttribute("avgInvestMoney", avgInvestMoney)
		.addAttribute("chart", chart).addAttribute("totalInvestMoney", totalInvestMoney);
	}

	@RequestMapping(value = "/movie/movieHome", method = RequestMethod.GET)
	public void movieHome(Model model) throws Exception{
		List<PaidMovieDTO> basicPaidList = new ArrayList<PaidMovieDTO>();
		List<PaidMovieDTO> lowPaidList = new ArrayList<PaidMovieDTO>();
		List<BasicMovieDTO> basicInfoList = new ArrayList<BasicMovieDTO>();
		List<BasicMovieDTO> lowInfoList = new ArrayList<BasicMovieDTO>();
		List<Map<String, Object>> reviewList = new ArrayList<Map<String,Object>>();
		List<BasicMovieDTO> basicMovieRecommendList = new ArrayList<BasicMovieDTO>(); // 영화 리스트
		List<BasicMovieDTO> lowMovieRecommendList = new ArrayList<BasicMovieDTO>(); // 영화 리스트
		// 유료 영화 리스트
		try{
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
				if(dto.getlNum()==0){
					view_map.put("kind", "basic");
					view_map.put("num", dto.getbNum());
					map.put("kind", "basic");
				}else{
					view_map.put("kind", "low");
					view_map.put("num", dto.getlNum());
					map.put("kind", "low");
				}
				BasicMovieDTO basicMovieDTO = new BasicMovieDTO();
				basicMovieDTO = basicMovieService.view(view_map);

				map.put("movieInfo", basicMovieDTO);
				map.put("reviewInfo", dto);
				reviewList.add(map);
			}
			// 영화 추천
			// 날씨별
			List<BasicMovieDTO> weatherMovie = new ArrayList<BasicMovieDTO>(); 
			Getweather getweather = new Getweather();
			String sky_code = getweather.getWeather();
			if(sky_code!=null){
				Map<String, Object> weather_map = new HashMap<String, Object>();
				weather_map.put("kind", "low");
				if(sky_code.equalsIgnoreCase("SKY_D01") ||sky_code.equalsIgnoreCase("SKY_D02")){
					weather_map.put("weather", 0);
				}else if(sky_code.equalsIgnoreCase("SKY_D03") ||sky_code.equalsIgnoreCase("SKY_D04")){
					weather_map.put("weather", 1);
				}else{
					weather_map.put("weather", 2);
				}
				weatherMovie = recommendService.genreList(weather_map);
				// basicMovieRecommendList.add(weatherMovie.get(0));
			}
			// 개봉예정작(low)
			List<BasicMovieDTO> pubMovie = new ArrayList<BasicMovieDTO>(); 
			Map<String, Object> pub_map = new HashMap<String, Object>();
			pub_map.put("kind", "low");
			pubMovie = recommendService.recentList(pub_map);
			lowMovieRecommendList.add(pubMovie.get(0));
			lowMovieRecommendList.add(pubMovie.get(1));
			lowMovieRecommendList.add(pubMovie.get(2));
			lowMovieRecommendList.add(pubMovie.get(3));
			// 개봉예정작(basic)
			List<BasicMovieDTO> pubMovie2 = new ArrayList<BasicMovieDTO>(); 
			pub_map.put("kind", "basic");
			pubMovie2 = recommendService.recentList(pub_map);
			basicMovieRecommendList.add(pubMovie2.get(0));
			basicMovieRecommendList.add(pubMovie2.get(1));
			basicMovieRecommendList.add(pubMovie2.get(2));
			basicMovieRecommendList.add(pubMovie2.get(3));

		} catch(Exception e){
			
		}
		model.addAttribute("basicInfoList", basicInfoList).addAttribute("lowInfoList", lowInfoList)
		.addAttribute("reviewList", reviewList).addAttribute("basicMovieRecommendList", basicMovieRecommendList)
		.addAttribute("lowMovieRecommendList", lowMovieRecommendList);
	}

}
