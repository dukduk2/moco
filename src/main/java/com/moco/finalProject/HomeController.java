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
		map.put("kind", "bNum");
		map.put("num", num);
		
		paidMovieDTO=paidMovieService.paidMovieSelectOne(map);

		model.addAttribute("dto", paidMovieDTO);
	}
	
	
	
	@RequestMapping(value="/movie/payMovie", method=RequestMethod.GET)
	public String payMovie(int num, Model model, HttpSession session) throws Exception{
		Map<String, Object> map1=new HashMap<String, Object>(); //pay
		Map<String, Object> map2=new HashMap<String, Object>(); //paidMovie
		Map<String, Object> map3=new HashMap<String, Object>(); //basicMovie
		String id=((MemberDTO)session.getAttribute("memberDTO")).getId();
		
		map3.put("num", num);
		map3.put("kind", "basic");
		
		map2.put("kind", "bNum");
		map2.put("num", num);
		
		PaidMovieDTO paidMovieDTO=new PaidMovieDTO();
		paidMovieDTO=paidMovieService.paidMovieSelectOne(map2);
		
		map1.put("id", id);
		map1.put("kind", "bNum");
		map1.put("num", num);
		
		PayDTO payDTO=new PayDTO();

		int myPoint=((MemberDTO)session.getAttribute("memberDTO")).getPoint();
		int price=paidMovieDTO.getPrice();
		
		/*model.addAttribute("myPoint", myPoint);
		model.addAttribute("price", price);*/
		model.addAttribute("dto", basicMovieService.view(map3));
		
		return "redirect:/movie/payMovie";
	}
	
	@RequestMapping(value="/movie/payMovie", method=RequestMethod.POST)
	public void payMovie(BasicMovieDTO basicMovieDTO, int num, HttpSession session) throws Exception{		
		Map<String, Object> map1=new HashMap<String, Object>(); //pay
		Map<String, Object> map2=new HashMap<String, Object>(); //paidMovie
		
		String id=((MemberDTO)session.getAttribute("memberDTO")).getId();
		
		map2.put("kind", "bNum");
		map2.put("num", num);
		
		PaidMovieDTO paidMovieDTO=new PaidMovieDTO();
		paidMovieDTO=paidMovieService.paidMovieSelectOne(map2);
		
		map1.put("id", id);
		map1.put("kind", "bNum");
		map1.put("num", num);
		
		PayDTO payDTO=new PayDTO();

		int myPoint=((MemberDTO)session.getAttribute("memberDTO")).getPoint();
		int price=paidMovieDTO.getPrice();
		
		/*System.out.println("myPoint"+myPoint);
		System.out.println("price"+price);
		
		if(price<=myPoint){
			map1.put("id", id);
			map1.put("kind", "bNum");
			map1.put("bnum", num);
		
			payService.payInsert(map1);
		}*/
	}
}
