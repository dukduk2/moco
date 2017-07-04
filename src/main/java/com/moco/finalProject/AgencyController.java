package com.moco.finalProject;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.moco.agency.AgencyDTO;
import com.moco.agency.AgencyService;
import com.moco.fileTest.FileSaver;
import com.moco.member.MemberDTO;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Controller
@RequestMapping(value="/user/agency/")
public class AgencyController {
	
	@Inject
	private AgencyService agencyService;
	
	@RequestMapping(value="agencyDelete", method=RequestMethod.GET)
	public String agencyDelete(int num) throws Exception{
		int result=0;
		result=agencyService.agencyDelete(num);
		return "redirect:/user/agency/agencyList";
	}
	
	@RequestMapping(value="agencyUpdate", method=RequestMethod.GET)
	public String agencyUpdate(int num, Model model) throws Exception{
		model.addAttribute("dto", agencyService.agencyView(num));
		return "user/agency/agencyUpdate";
	}
	
	@RequestMapping(value="agencyUpdate", method=RequestMethod.POST)
	public String agencyUpdate(AgencyDTO agencyDTO, int num, @RequestParam(value="f1") MultipartFile multipartFile, HttpSession session) throws Exception{
		String path=session.getServletContext().getRealPath("resources/upload/agency");
		FileSaver fileSaver=new FileSaver();
		
		if(multipartFile.getOriginalFilename()!=""){
			agencyDTO.setOname(multipartFile.getOriginalFilename());
			agencyDTO.setFname(fileSaver.saver(multipartFile, path));
		}else{
			AgencyDTO agencyDTO2=agencyService.agencyView(num);
			agencyDTO.setFname(agencyDTO2.getFname());
			agencyDTO.setOname(agencyDTO2.getOname());
		}
		
		int result=0;
		result=agencyService.agencyUpdate(agencyDTO);
		
		return "redirect:/user/agency/agencyList";
	}
	
	@RequestMapping(value="agencyList", method=RequestMethod.GET)
	public void agencyList(Integer curPage, Integer perPage, Model model, HttpSession session) throws Exception{
		Map<String, Object> map=new HashMap<String, Object>();
		String name=((MemberDTO)session.getAttribute("memberDTO")).getName();
		
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
		map.put("director", name);
		
		PageMaker pageMaker=new PageMaker(curPage, perPage);
		int totalCount=agencyService.agencyListCount(name);

		PageResult pageResult=pageMaker.paging(totalCount);
		
		List<AgencyDTO> ar=agencyService.agencyList(map);
		
		model.addAttribute("map", map);
		model.addAttribute("pageResult", pageResult);
		model.addAttribute("list", ar);
		model.addAttribute("totalCount", totalCount);

	}
	
	@RequestMapping(value="agencyView", method=RequestMethod.GET)
	public String agencyView(int num, Model model) throws Exception{
		AgencyDTO agencyDTO=new AgencyDTO();
		agencyDTO=agencyService.agencyView(num);
		model.addAttribute("dto", agencyDTO);
		return "/user/agency/agencyView";
	}

	@RequestMapping(value="agencyRequest", method=RequestMethod.GET)
	public void agencyRequest(){
		
	}
	
	@RequestMapping(value="agencyRequest", method=RequestMethod.POST)
	public String agencyRequest(AgencyDTO agencyDTO, @RequestParam(value="f1") MultipartFile multipartFile, HttpSession session){
		// 파일 upload
		String path = session.getServletContext().getRealPath("resources/upload/agency");
		agencyDTO.setOname(multipartFile.getOriginalFilename());
		FileSaver fileSaver = new FileSaver();
		try {
			agencyDTO.setFname(fileSaver.saver(multipartFile, path));
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		// 글 등록
		int result=0;
		
		try {
			result=agencyService.agencyRequest(agencyDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:/user/agency/agencyList";

	}
}
