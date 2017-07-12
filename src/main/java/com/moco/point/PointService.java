package com.moco.point;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.util.RowMaker;

@Service
public class PointService {

	@Autowired
	private PointDAO pointDAO;

	// pointList
	public List<PointDTO> pointList(int curPage, String id) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		
		RowMaker rowMaker = new RowMaker();
		rowMaker.makeRow(curPage, 10);
		map.put("row", rowMaker);
		return pointDAO.pointList(map);
	}

	// pointInsert
	public int pointInsert(PointDTO pointDTO) throws Exception{
		return pointDAO.pointInsert(pointDTO);
	}

	// totalCount
	public int totalCount(String id) throws Exception{
		return pointDAO.totalCount(id);
	}

}
