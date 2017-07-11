package com.moco.finalProject;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.lowpricemovie.LowPriceMovieService;
import com.moco.member.MemberDTO;
import com.moco.member.MemberService;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.BasicMovieService;
import com.moco.paidMovie.PaidMovieDTO;
import com.moco.paidMovie.PaidMovieService;
import com.moco.pay.PayService;

@Controller
@RequestMapping(value="/movie")
public class MoviePayAndViewController {

	@Inject
	PaidMovieService paidMovieService;
	@Inject
	MemberService memberService;
	@Inject
	BasicMovieService basicMovieService;
	@Inject
	LowPriceMovieService lowPriceMovieService;
	@Inject
	PayService payService;
	
	@RequestMapping(value="/moviePlay", method=RequestMethod.GET)
	public void moviePlay(int num, Model model) throws Exception{
		Map<String, Object> basic_map=new HashMap<String, Object>(); //basicMovie
		Map<String, Object> low_map=new HashMap<String, Object>(); //lowMovie

		basic_map.put("num", num);
		basic_map.put("kind", "basic");
		
		low_map.put("num", num);
		low_map.put("kind", "low");

		PaidMovieDTO basicDTO=new PaidMovieDTO();
		basicDTO=paidMovieService.paidMovieSelectOne(basic_map);
		
		PaidMovieDTO lowDTO=new PaidMovieDTO();
		lowDTO=paidMovieService.paidMovieSelectOne(low_map);
		
		if(basicDTO!=null){
			model.addAttribute("dto", basicDTO);
		}else if(lowDTO!=null){
			model.addAttribute("dto", lowDTO);
		}

	}

	
	@RequestMapping(value="/payMovie", method=RequestMethod.GET)
	public void payMovie(int num, Model model, HttpSession session) throws Exception{
		Map<String, Object> basic_map=new HashMap<String, Object>(); //basicMovie
		Map<String, Object> low_map=new HashMap<String, Object>(); //lowMovie

		basic_map.put("num", num);
		basic_map.put("kind", "basic");
		
		low_map.put("num", num);
		low_map.put("kind", "low");

		PaidMovieDTO basicDTO=new PaidMovieDTO();
		basicDTO=paidMovieService.paidMovieSelectOne(basic_map);
		
		PaidMovieDTO lowDTO=new PaidMovieDTO();
		lowDTO=paidMovieService.paidMovieSelectOne(low_map);
		
		int price=0;
		
		if(basicDTO!=null){
			model.addAttribute("dto", basicMovieService.view(basic_map));
			price=basicDTO.getPrice();
		}else if(lowDTO!=null){
			model.addAttribute("dto", lowPriceMovieService.view(num));
			price=lowDTO.getPrice();
		}
		int myPoint=((MemberDTO)session.getAttribute("memberDTO")).getPoint();
		
		model.addAttribute("myPoint", myPoint);
		model.addAttribute("price", price);
		
		
	}
	
	@RequestMapping(value="/payMovie", method=RequestMethod.POST)
	public String payMovie(BasicMovieDTO basicMovieDTO, LowPriceMovieDTO lowPriceMovieDTO, int num, HttpSession session) throws Exception{		
		Map<String, Object> pay_map=new HashMap<String, Object>(); //pay
		Map<String, Object> basic_map=new HashMap<String, Object>(); //basicMovie
		Map<String, Object> low_map=new HashMap<String, Object>();
		//String id=((MemberDTO)session.getAttribute("memberDTO")).getId();
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("memberDTO");
		int myPoint=((MemberDTO)session.getAttribute("memberDTO")).getPoint();
		String id=((MemberDTO)session.getAttribute("memberDTO")).getId();
		
		basic_map.put("num", num);
		basic_map.put("kind", "basic");
		
		low_map.put("num", num);
		low_map.put("kind", "low");

		PaidMovieDTO basicDTO=new PaidMovieDTO();
		basicDTO=paidMovieService.paidMovieSelectOne(basic_map);
		
		PaidMovieDTO lowDTO=new PaidMovieDTO();
		lowDTO=paidMovieService.paidMovieSelectOne(low_map);
		int price=0;
		if(basicDTO!=null){
			price=basicDTO.getPrice();
			
			if(price<=myPoint){
				pay_map.put("id", id);
				pay_map.put("kind", "basic");
				pay_map.put("num", num);
			
				payService.payInsert(pay_map);
				
				myPoint=myPoint-price;
				
				memberDTO.setPoint(myPoint);
				memberService.pointUpdate(memberDTO);
			}
		}else if(lowDTO!=null){
			price=lowDTO.getPrice();
			
			if(price<=myPoint){
				pay_map.put("id", id);
				pay_map.put("kind", "low");
				pay_map.put("num", num);
			
				payService.payInsert(pay_map);
				
				myPoint=myPoint-price;
				
				memberDTO.setPoint(myPoint);
				memberService.pointUpdate(memberDTO);
			}
			
		}		
		return "redirect:moviePlay?num="+num;
	
	}
	
}
