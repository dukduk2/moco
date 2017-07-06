package com.moco.pay;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class PayService {

	@Inject
	private PayDAO payDAO;
	
	public List<PayDTO> paySelectList() throws Exception{
		return payDAO.paySelectList();
	}
	
	public int payInsert(PayDTO payDTO) throws Exception{
		return payDAO.payInsert(payDTO);
	}
	
	public PayDTO paySelectOne1(PayDTO payDTO) throws Exception{
		return payDAO.paySelectOne1(payDTO);
	}
	
	public PayDTO paySelectOne2(PayDTO payDTO) throws Exception{
		return payDAO.paySelectOne2(payDTO);
	}
}
