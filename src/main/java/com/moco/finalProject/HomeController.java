package com.moco.finalProject;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
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
import com.moco.paidMovie.PaidMovieDTO;
import com.moco.paidMovie.PaidMovieService;
import com.moco.pay.PayDTO;
import com.moco.pay.PayService;

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
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/user/userHome", method = RequestMethod.GET)
	public void userHome(){
		
	}
	
	@RequestMapping(value = "/movie/movieHome", method = RequestMethod.GET)
	public void movieHome(){
		
	}
	
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
}
