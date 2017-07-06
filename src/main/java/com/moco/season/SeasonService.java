package com.moco.season;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.member.MemberDTO;
import com.moco.userBoard.UserBoardDTO;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Service
public class SeasonService {

	@Autowired
	private SeasonDAO seasonDAO;

	// seasonEndLikesUpdate
	public void seasonEndLikesUpdate(String season) throws Exception{
		// 1. 현재 시즌으로 글쓴이들 불러오기
		List<String> members = seasonDAO.seasonWriter(season);
		// 2. 한명이 쓴 글의 likes 갯수 가져오기
		for (String member : members) {
			UserBoardDTO userBoardDTO = new UserBoardDTO();
			userBoardDTO.setWriter(member);
			userBoardDTO.setSeason(season);
			int likes = seasonDAO.seasonLikesCount(userBoardDTO);
			// 3. 불러온 likes 수 만큼 memberTableUpdate 해주기
			MemberDTO memberDTO = new MemberDTO();
			memberDTO.setId(member);
			memberDTO.setLikes(likes);
			memberDTO.setAvaliableLikes(likes);
			int result = seasonDAO.memberLikesUpdate(memberDTO);
			if(result>0){
				System.out.println("member에게 likes, avaliableLikes가 적립되었습니다.");
			}
		}
	}
	
	// likesAbleCheck
	public boolean likesAbleCheck(SeasonDTO seasonDTO) throws Exception{
		boolean check = true;
		// 시즌이 끝났다면, false
		if(seasonDAO.likesAbleCheck(seasonDTO) == 0){
			check = !check;
		}
		return check;
	}

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
