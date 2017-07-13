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

import com.moco.lowpricemovie.LowPriceMovieDTO;
import com.moco.lowpricemovie.LowPriceMovieService;
import com.moco.member.MemberDTO;
import com.moco.member.MemberService;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.BasicMovieService;
import com.moco.paidMovie.PaidMovieDTO;
import com.moco.paidMovie.PaidMovieService;
import com.moco.pay.PayService;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

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
	
	@RequestMapping(value="/payMovieList/payMovieBasic", method=RequestMethod.GET)
	public String payMovieBasic(Integer curPage, String title, Model model){		
		List<BasicMovieDTO> ar=new ArrayList<BasicMovieDTO>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(curPage==null){
			curPage=1;
		}
		if(title==null){
			title="%";
		}
		map.put("title", title);
		System.out.println("title"+title);
		//map.put("curPage", curPage);
		PageResult pageResult = null;
		try{
		int totalCount=0;
		totalCount=paidMovieService.payMovieBasicCount(map);
		System.out.println("totalCount"+totalCount);
		
		PageMaker pageMaker = new PageMaker(curPage);
		RowMaker rowMaker = pageMaker.getRowMaker();
		pageResult = pageMaker.paging(totalCount);
		System.out.println("StartRow"+rowMaker.getStartRow());
		System.out.println("LastRow"+rowMaker.getLastRow());
		map.put("rowMaker", rowMaker);

		ar = paidMovieService.payMovieBasic(map);
		
		System.out.println("ar size"+ar.size());
		for(int i=0;i<ar.size();i++){
			System.out.println(ar.get(i).getTitle());
		}
		}catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("list", ar);
		model.addAttribute("pageResult", pageResult);
		model.addAttribute("title", title);
		model.addAttribute("curPage", curPage);
		return "movie/payMovieList/payMovieBasic";
	}
	
	@RequestMapping(value="/payMovieList/payMovieLow", method=RequestMethod.GET)
	public String payMovieLow(String title, Integer curPage, Model model) throws Exception{		
		List<LowPriceMovieDTO> ar=new ArrayList<LowPriceMovieDTO>();
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(curPage==null){
			curPage=1;
		}
		if(title==null){
			title="%";
		}
		map.put("title", title);
		int totalCount=0;
		
		totalCount=paidMovieService.payMovieLowCount(map);
		
		PageMaker pageMaker = new PageMaker(curPage);
		RowMaker rowMaker = pageMaker.getRowMaker();
		PageResult pageResult = pageMaker.paging(totalCount);
		map.put("rowMaker", rowMaker);
		
		ar = paidMovieService.payMovieLow(map);
		for(int i=0;i<ar.size();i++){
			System.out.println(ar.get(i).getTitle());
		}
		model.addAttribute("list", ar);
		model.addAttribute("pageResult", pageResult);
		model.addAttribute("title", title);
		model.addAttribute("curPage", curPage);
		return "movie/payMovieList/payMovieLow";
	}
	
	@RequestMapping(value="/moviePlay", method=RequestMethod.GET)
	public void moviePlay(int num, Model model, String kind) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("kind", kind);
		map.put("num", num);
		PaidMovieDTO paidMovieDTO = new PaidMovieDTO();
		paidMovieDTO = paidMovieService.paidMovieSelectOne(map);
		model.addAttribute("dto", paidMovieDTO);
	}

	
	@RequestMapping(value="/payMovie", method=RequestMethod.GET)
	public void payMovie(int num, Model model, HttpSession session, String kind) throws Exception{
		Map<String, Object> map=new HashMap<String, Object>();
		
		map.put("kind", kind);
		map.put("num", num);
		PaidMovieDTO paidMovieDTO=new PaidMovieDTO();
		paidMovieDTO=paidMovieService.paidMovieSelectOne(map);
		
		int price=0;
		
		price=paidMovieDTO.getPrice();
		
		if(paidMovieDTO.getbNum()!=0){
			model.addAttribute("dto", basicMovieService.view(map));
		}else if(paidMovieDTO.getlNum()!=0){
			model.addAttribute("dto", lowPriceMovieService.view(num));
		}
		int myPoint=((MemberDTO)session.getAttribute("memberDTO")).getPoint();
		
		model.addAttribute("kind", kind);
		model.addAttribute("myPoint", myPoint);
		model.addAttribute("price", price);
	}
	
	@RequestMapping(value="/payMovie", method=RequestMethod.POST)
	public String payMovie(BasicMovieDTO basicMovieDTO, LowPriceMovieDTO lowPriceMovieDTO, int num, HttpSession session, String kind) throws Exception{		
		Map<String, Object> pay_map=new HashMap<String, Object>(); //pay
		Map<String, Object> map=new HashMap<String, Object>();
		
		MemberDTO memberDTO=(MemberDTO)session.getAttribute("memberDTO");
		int myPoint=((MemberDTO)session.getAttribute("memberDTO")).getPoint();
		String id=((MemberDTO)session.getAttribute("memberDTO")).getId();
		
		map.put("kind", kind);
		map.put("num", num);

		PaidMovieDTO paidMovieDTO=new PaidMovieDTO();
		paidMovieDTO=paidMovieService.paidMovieSelectOne(map);
		
		int price=0;
		price=paidMovieDTO.getPrice();
		if(paidMovieDTO.getbNum()!=0){
			
			if(price<=myPoint){
				pay_map.put("id", id);
				pay_map.put("kind", "basic");
				pay_map.put("num", num);
			
				payService.payInsert(pay_map);
				
				myPoint=myPoint-price;
				
				memberDTO.setPoint(myPoint);
				memberService.pointUpdate(memberDTO);
			}
		}else if(paidMovieDTO.getlNum()!=0){
			
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
		return "redirect:moviePlay?num="+num+"&kind="+kind;
	}	
}
