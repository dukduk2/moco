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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moco.actorPR.ActorPRDTO;
import com.moco.actorPR.ActorPRService;
import com.moco.fileTest.FileSaver;
import com.moco.member.MemberDTO;
import com.moco.member.MemberService;
import com.moco.reply.ReplyService;
import com.moco.season.SeasonDTO;
import com.moco.season.SeasonService;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Controller
@RequestMapping(value="/user/actorPR/")
public class ActorPRController {

	@Inject
	private ActorPRService actorPRService;
	@Inject
	private SeasonService seasonService;
	@Inject
	private MemberService memberService;
	@Inject
	private ReplyService replyService;
	
	@RequestMapping(value="actorPRDelete", method=RequestMethod.GET)
	public String actorPRDelete(int num){
		int result=0;
		Map<String, Object> map=new HashMap<String, Object>();
		
		try {
			map.put("anum", num); //내꺼
			map.put("unum", 0);
			result=actorPRService.actorPRDelete(num);
			replyService.replyDelete2(map);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/user/actorPR/actorPRList";
	}
	
	@RequestMapping(value="actorPRView", method=RequestMethod.GET)
	public String actorPRView(int num, Model model) throws Exception{
		ActorPRDTO actorPRDTO=new ActorPRDTO();
		actorPRDTO=actorPRService.actorPRView(num);
		actorPRService.hitUpdate(true, num);
		model.addAttribute("dto", actorPRDTO);
		return "user/actorPR/actorPRView";
	}
	
	@RequestMapping(value="actorPRWrite", method=RequestMethod.GET)
	public void actorPRWrite(Model model) throws Exception {
		SeasonDTO seasonDTO=seasonService.adminOrderSelectOne("actor");
		model.addAttribute("season", seasonDTO.getSeason());
	}
	
	@RequestMapping(value="actorPRWrite", method=RequestMethod.POST)
	public String actorPRWrite(ActorPRDTO actorPRDTO, Model model, @RequestParam(value="f1") MultipartFile multipartFile, HttpSession session){
		String path=session.getServletContext().getRealPath("resources/upload/actorPR");
		actorPRDTO.setOname(multipartFile.getOriginalFilename());
		FileSaver fileSaver=new FileSaver();
		try{
			actorPRDTO.setFname(fileSaver.saver(multipartFile, path));
		} catch (Exception e1){
			e1.printStackTrace();
		}
		
		int result=0;		
		
		try {
			result=actorPRService.actorPRWrite(actorPRDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/user/actorPR/actorPRList";
	}
	
	@RequestMapping(value="voteCountUpdate", method=RequestMethod.GET)
	public void voteCountUpdate() throws Exception{
		
	}
	
	@RequestMapping(value="voteCountUpdate", method=RequestMethod.POST)
	public String voteCountUpdate(ActorPRDTO actorPRDTO, String vote, HttpSession session) throws Exception{
		String[] vote2=vote.split(",");
		String[] writer=null;
		Integer[] result=null;
		String id= ((MemberDTO)session.getAttribute("memberDTO")).getId();
		int votelist=0;

		if(actorPRService.voteListSelect(id)==null){	
			votelist=actorPRService.voteListInsert(id);
			
			if(vote2!=null){
				writer=new String[vote2.length];
				result=new Integer[vote2.length];
				for(int i=0;i<vote2.length;i++){
					writer[i]=vote2[i];
					result[i]=actorPRService.voteCountUpdate(writer[i]);
				}
			}
		}
	
		return "redirect:/user/actorPR/actorPRList";
	}
	
	@RequestMapping(value="actorPRUpdate", method=RequestMethod.GET)
	public String actorPRUpdate(int num, Model model) throws Exception {
		SeasonDTO seasonDTO=seasonService.adminOrderSelectOne("actor");
		model.addAttribute("season", seasonDTO.getSeason());
		model.addAttribute("dto", actorPRService.actorPRView(num));
		return "user/actorPR/actorPRUpdate";
	}
	
	@RequestMapping(value="actorPRUpdate", method=RequestMethod.POST)
	public String actorPRUpdate(ActorPRDTO actorPRDTO,int num, @RequestParam(value="f1") MultipartFile multipartFile, HttpSession session){
		String path=session.getServletContext().getRealPath("resources/upload/actorPR");
		FileSaver fileSaver=new FileSaver();
		
		try{
			if(multipartFile.getOriginalFilename()!=""){
				actorPRDTO.setOname(multipartFile.getOriginalFilename());
				actorPRDTO.setFname(fileSaver.saver(multipartFile, path));
			}else{
				ActorPRDTO actorPRDTO2 = actorPRService.actorPRView(num);
				actorPRDTO.setFname(actorPRDTO2.getFname());
				actorPRDTO.setOname(actorPRDTO2.getOname());
			}
		} catch (Exception e1){
			e1.printStackTrace();
		}
		
		int result=0;		
		
		try {
			result=actorPRService.actorPRUpdate(actorPRDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/user/actorPR/actorPRList";
	}
	
	@RequestMapping(value="actorPRList", method=RequestMethod.GET)
	public void actorPRList(String season, Integer sort, String search, Model model, HttpSession session) throws Exception{
		Map<String, Object> map=new HashMap<String, Object>();
		String id= ((MemberDTO)session.getAttribute("memberDTO")).getId();
		if(sort == null){
			sort =1;
		}
		
		List<String> onames = new ArrayList<String>();

		String oname = "";
		
		String curSeason=seasonService.adminOrderSelectOne("actor").getSeason();
				
		if(season==null){
			season=curSeason;	
		}
		if(search==null){
			search="%";
		}
		
		map.put("season", season);
		map.put("search", search);


		int totalCount=actorPRService.totalCount(map);

		List<ActorPRDTO> ar = new ArrayList<ActorPRDTO>();
		if(sort ==1){
			ar=actorPRService.actorPRList2(map); //이름순
		}else{
			ar=actorPRService.actorPRList1(map); //인기순
		}
		
		// fnames : 배우들 이미지
		for(int i=0; i<ar.size();i++){
			oname = actorPRService.onameSelect(ar.get(i).getWriter());
			onames.add(oname);
		}
		
		if(actorPRService.voteListSelect(id)!=null){
			model.addAttribute("message", "no");
		}else{
			model.addAttribute("message", "");
		}
		
		model.addAttribute("fnames", onames);

		model.addAttribute("map", map);
		model.addAttribute("list", ar);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("sort", sort);
		List<SeasonDTO> seasonList=seasonService.adminOrderSelect("actor");
		model.addAttribute("orderList", seasonList);
		
		SeasonDTO seasonDTO = seasonService.adminOrderCheck("actor");
		if(seasonDTO != null){
			model.addAttribute("seasonCheck", true);
		}else{
			model.addAttribute("seasonCheck", false);
		}
	}
}
