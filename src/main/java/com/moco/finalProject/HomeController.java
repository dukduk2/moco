package com.moco.finalProject;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.moco.member.MemberService;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.BasicMovieService;
import com.moco.notice.NoticeDTO;
import com.moco.notice.NoticeService;
import com.moco.paidMovie.PaidMovieDTO;
import com.moco.paidMovie.PaidMovieService;
import com.moco.pay.PayDTO;
import com.moco.pay.PayService;
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
	MemberService memberService;
	
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
		try {
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
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("basicInfoList", basicInfoList).addAttribute("lowInfoList", lowInfoList);
	}
}
