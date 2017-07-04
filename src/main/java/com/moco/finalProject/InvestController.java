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

import com.moco.directorBoard.DirectorBoardDTO;
import com.moco.directorBoard.DirectorBoardService;
import com.moco.directorBoard.invest.InvestDTO;
import com.moco.directorBoard.invest.InvestService;
import com.moco.member.MemberDTO;

@Controller
public class InvestController {
	@Inject
	InvestService investService;
	@Inject
	DirectorBoardService directorBoardService;
	
	@RequestMapping(value="/user/directorBoard/investInsert", method=RequestMethod.POST)
	public String investInsert(InvestDTO investDTO, HttpSession session){
		int result = 0;
		try {
			// 첫투자, 재투자 체크
			if(investService.reInvestCheck(investDTO) != null){
				investService.reInvest(investDTO);
			}else{
				result = investService.insert(investDTO);
			}
			// directorBoard의 현재 투자금 업데이트
			investService.curPriceUpdate(investDTO);
			
			// member의 가용포인트 업데이트
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("kind", "investor");
			map.put("flag", "minus");
			map.put("money", investDTO.getMoney());
			map.put("id", investDTO.getId());
			investService.avaliableLikesUpdate(map);
			System.out.println("money : "+investDTO.getMoney());
			// curPrice = targetPrice 체크
			DirectorBoardDTO directorBoardDTO = (DirectorBoardDTO) directorBoardService.view(investDTO.getPnum());
			if(directorBoardDTO.getCurPrice() == directorBoardDTO.getTargetPrice()){
				directorBoardService.stateUpdateFinish(investDTO.getPnum()); // state update
				Map<String, Object> director_map = new HashMap<String, Object>();
				int totalMoney = investService.totalMoney(investDTO.getPnum());
				director_map.put("kind", "director");
				director_map.put("totalMoney", totalMoney);
				director_map.put("id", directorBoardDTO.getWriter());
				investService.avaliableLikesUpdate(director_map);
			}
			// session 재설정
			String id = ((MemberDTO) session.getAttribute("memberDTO")).getId();
			MemberDTO memberDTO = investService.investorInfo(id);
			
			session.setAttribute("memberDTO", memberDTO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:directorBoardView?num="+investDTO.getPnum();
	}
	
	@RequestMapping(value="/user/directorBoard/investorList", method=RequestMethod.GET)
	public void investorList(int pnum, Model model) {
		int countInvestors = 0;
		List<InvestDTO> investorList = new ArrayList<InvestDTO>();
		ArrayList<Map<String, Object>> ar = new ArrayList<Map<String,Object>>();
		try {
			countInvestors = investService.countInvestors(pnum);
			investorList = investService.investorList(pnum);
			for(InvestDTO investDTO : investorList){
				Map<String, Object> map = new HashMap<String, Object>();
				MemberDTO memberDTO = new MemberDTO();
				memberDTO = investService.investorInfo(investDTO.getId());
				map.put("memberDTO", memberDTO);
				map.put("money", investDTO.getMoney());
				ar.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(ar.size()==0){
			model.addAttribute("noList", "NO LIST");
		}
		model.addAttribute("countInvestors", countInvestors)
		.addAttribute("list", ar);
	}
}
