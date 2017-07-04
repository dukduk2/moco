package com.moco.season;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Service
public class SeasonService {

	@Autowired
	private SeasonDAO seasonDAO;

	// adminOrderSelect - parameter > String kind , result > List<SeasonDTO>
	public List<SeasonDTO> adminOrderSelect(String kind) throws Exception{
		return seasonDAO.adminOrderSelect(kind);
	}

	// adminOrderSelect - parameter > String kind , result > List<SeasonDTO>
	public List<SeasonDTO> adminOrderSelect2(Integer curPage, int perPage, String kind) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		// pageing
		RowMaker rowMaker = new RowMaker();
		rowMaker.makeRow(curPage, perPage);

		map.put("kind", kind);
		map.put("row", rowMaker);
		
		return seasonDAO.adminOrderSelect2(map);
	}
	// adminOrderSelectOne - parameter String kind, result > SeasonDTO
	public SeasonDTO adminOrderSelectOne(String kind) throws Exception{
		return seasonDAO.adminOrderSelectOne(kind);
	}
	// adminOrderInsert - parameter SeasonDTO
	public int adminOrderInsert(SeasonDTO seasonDTO) throws Exception{
		return seasonDAO.adminOrderInsert(seasonDTO);
	}
	// adminOrderStart - parameter int
	public int adminOrderStart(int num) throws Exception{
		return seasonDAO.adminOrderStart(num);
	}
	// adminOrderEnd - parameter int
	public int adminOrderEnd(int num) throws Exception{
		return seasonDAO.adminOrderEnd(num);
	}
	//adminOrderDelete - parameter int
	public int adminOrderDelete(int num) throws Exception{
		return seasonDAO.adminOrderDelete(num);
	}
	// adminOrderCheck - parameter String , ResultType SeasonDTO
	public SeasonDTO adminOrderCheck(String kind) throws Exception{
		return seasonDAO.adminOrderCheck(kind);
	}

	// seasonTotalCount
	public int seasonTotalCount(String kind) throws Exception{
		return seasonDAO.seasonTotalCount(kind);
	}

}
