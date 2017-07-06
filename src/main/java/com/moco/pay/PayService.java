package com.moco.pay;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class PayService {

	@Inject
	private PayDAO payDAO;
	
	public List<PayDTO> paySelectList() throws Exception{
		return payDAO.paySelectList();
	}
	
	public int payInsert(Map<String, Object> map) throws Exception{
		return payDAO.payInsert(map);
	}
}
