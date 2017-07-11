package com.moco.directorBoard.invest;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.moco.member.MemberDTO;

@Service
public class InvestService {
	@Inject
	InvestDAO investDAO;
	
	public int insert(InvestDTO investDTO) throws Exception{
		return investDAO.insert(investDTO);
	}
	
	public int deleteInvest(int pnum) throws Exception{
		return investDAO.deleteInvest(pnum);
	}
	
	public int update(InvestDTO investDTO) throws Exception{
		return investDAO.update(investDTO);
	}
	
	public InvestDTO selectOne(InvestDTO investDTO) throws Exception{
		return investDAO.selectOne(investDTO);
	}
	
	public List<InvestDTO> investorList(int pnum) throws Exception{
		return investDAO.investorList(pnum);
	}
	
	public int curPriceUpdate(InvestDTO investDTO) throws Exception{
		return investDAO.curPriceUpdate(investDTO);
	}
	
	public int reInvest(InvestDTO investDTO) throws Exception{
		return investDAO.reInvest(investDTO);
	}
	
	public int countInvestors(int pnum) throws Exception{
		return investDAO.countInvestors(pnum);
	}
	
	public int myInvestMoney(Map<String, Object> map) throws Exception{
		return investDAO.myInvestMoney(map);
	}
	
	public int avaliableLikesUpdate(Map<String, Object> map) throws Exception{
		return investDAO.avaliableLikesUpdate(map);
	}
	
	public List<InvestDTO> checkPnum(int pnum) throws Exception{
		return investDAO.checkPnum(pnum);
	}
	
	public int totalMoney(int pnum) throws Exception{
		return investDAO.totalMoney(pnum);
	}
	
	public MemberDTO investorInfo(String id) throws Exception{
		return investDAO.investorInfo(id);
	}
	
	public InvestDTO reInvestCheck(InvestDTO investDTO) throws Exception{
		return investDAO.reInvestCheck(investDTO);
	}
	
	public int totalInvestor() throws Exception{
		return investDAO.totalInvestor();
	}
	
	public int avgInvestMoney() throws Exception{
		return investDAO.avgInvestMoney();
	}
	
	public int totalCount() throws Exception{
		return investDAO.totalCount();
	}
	
	public int successCount() throws Exception{
		return investDAO.successCount();
	}
	
	public int totalInvestMoney() throws Exception{
		return investDAO.totalInvestMoney();
	}
}
