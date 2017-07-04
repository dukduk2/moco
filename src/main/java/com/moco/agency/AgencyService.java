package com.moco.agency;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class AgencyService {
	
	@Inject
	private AgencyDAO agencyDAO;
	
	public List<AgencyDTO> agencyList(Map<String, Object> map) throws Exception{
		return agencyDAO.agencyList(map);
	}
	
	public int agencyListCount(String name) throws Exception{
		return agencyDAO.agencyListCount(name);
	}
	
	public int agencyCommitCount(Map<String, Object> map) throws Exception{
		return agencyDAO.agencyCommitCount(map);
	}
	
	public int agencyUncommitCount() throws Exception{
		return agencyDAO.agencyUncommitCount();
	}
	
	public int agencyUpdate(AgencyDTO agencyDTO) throws Exception{
		return agencyDAO.agencyUpdate(agencyDTO);
	}
	
	public int agencyDelete(int num) throws Exception{
		return agencyDAO.agencyDelete(num);
	}
	
	public List<AgencyDTO> agencyCommitList(Map<String, Object> map) throws Exception{
		return agencyDAO.agencyCommitList(map);
	}
	
	public List<AgencyDTO> agencyUncommitList(Map<String, Object> map) throws Exception{
		return agencyDAO.agencyUncommitList(map);
	}
	
	public AgencyDTO agencyView(int num) throws Exception{
		AgencyDTO agencyDTO=new AgencyDTO();
		
		agencyDTO=agencyDAO.agencyView(num);
		return agencyDTO;
	}
	
	public int agencyRequest(AgencyDTO agencyDTO) throws Exception{
		int result=agencyDAO.agencyRequest(agencyDTO);
		return result;
	}
	
	public int agencyCommit(int num) throws Exception{
		int result=agencyDAO.agencyCommit(num);
		return result;
	}
	
	public int agencyCommitCancel(int num) throws Exception{
		return agencyDAO.agencyCommitCancel(num);
	}
}
