package com.moco.reservation;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReservationDAO {
	
	@Autowired
	private SqlSession sqlSession;
	private static final String NAMESPACE = "ReservationMapper.";
	
	//프로시저 사용.(reservation db insert & screen db update)
	public int insert(ReservationDTO reservationDTO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reservationDTO", reservationDTO);
		
		sqlSession.insert(NAMESPACE+"insert", map);
		int result = (Integer)map.get("result");
		
		return result;
	}
}
