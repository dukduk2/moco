package com.moco.userBoard;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.moco.board.BoardDAO;
import com.moco.board.BoardDTO;
import com.moco.likes.LikesDTO;
import com.moco.member.MemberDTO;
import com.moco.season.SeasonDTO;
@Repository
public class UserBoardDAO implements BoardDAO {
	
	@Inject
	private SqlSession sqlSession;
	private static final String NAMESPACE="UserBoardMapper.";
	
	////////////////////////////////////////////////////LIKES //////////////////////////////////////////////////
	// board삭제에 따른 likes 삭제
	public int likesDelete2(int num) throws Exception{
		return sqlSession.delete(NAMESPACE+"likesDelete2", num);
	}
	// boardLikesCount 
	public int boardLikesCount(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"boardLikesCount", num);
	}
	// viewPage에 접근한 user가 현재 게시물에 '좋아요'를 하였는지 check
	public boolean likesCheck(LikesDTO likesDTO) throws Exception{
		// likesDTO의 unum >
		boolean check = false;
		String id = likesDTO.getId();
		id = sqlSession.selectOne(NAMESPACE+"likesCheck", likesDTO);
		if(id != null){ // 읽어들인 결과물이 있다면. 즉, likesTable에 저장되어있다면. 좋아요를 누른것.
			check = true;
		}
		return check;
	}
	// likesInsert >> likesTableInsert, userBoardTableUpdate
	public int likesInsert(LikesDTO likesDTO) throws Exception{
		int result = 0;
		// 1. likes Table Insert
		result = sqlSession.insert(NAMESPACE+"likesInsert", likesDTO);
		// 2. UserBoard Table Update
		result += sqlSession.update(NAMESPACE+"boardLikesPlus", likesDTO.getUnum());
		return result;
	}
	// likesDelete >> likesTableDelete, userBoardTableUpdate
	public int likesDelete(LikesDTO likesDTO) throws Exception{
		int result = 0;
		// 1. likes Table Delete
		result = sqlSession.delete(NAMESPACE+"likesDelete", likesDTO);
		// 2. UserBoard Table Update
		result += sqlSession.update(NAMESPACE+"boardLikesMinus", likesDTO.getUnum());
		return result;
	}
	
	///////////////////////////////////////////////USERBOARD COMMIT & VIDEO STATE ////////////////////////////////////////////
	
	// adminIndexCount
	public int adminIndexCount() throws Exception{
		return sqlSession.selectOne(NAMESPACE+"adminIndexCount");
	}
	
	// Admin userBoardCommit Update
	public void adminCommitUpdate(int num) throws Exception{
		sqlSession.update(NAMESPACE+"adminCommitUpdate", num);
	}
	
	// Admin userBoardVideoState Update
	public void adminVideoStateUpdate(int num) throws Exception{
		sqlSession.update(NAMESPACE+"adminVideoStateUpdate", num);
	}
	
	// Admin adminCommitSelect
	public List<UserBoardDTO> adminCommitSelect(Map<String, Object> map) throws Exception{
		return sqlSession.selectList(NAMESPACE+"adminCommitSelect", map);
	}
	
	// Admin adminTotalCount
	public int adminTotalCount(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"adminTotalCount", map);
	}
	
	/////////////////////////////////////////////////USERBOARD /////////////////////////////////////////////////////////////////////
	
	public String userBoardContents(int num) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"userBoardContents", num);
	}
	
	@Override
	public List<BoardDTO> list(Map<String, Object> map) throws Exception {
		return sqlSession.selectList(NAMESPACE+"list", map);
	}

	@Override
	public BoardDTO view(int num) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"view", num);
	}

	@Override
	public int write(BoardDTO boardDTO) throws Exception {
		return sqlSession.insert(NAMESPACE+"write", boardDTO);
	}

	@Override
	public int update(BoardDTO boardDTO) throws Exception {
		return sqlSession.update(NAMESPACE+"update", boardDTO);
	}

	@Override
	public int delete(int num) throws Exception {
		return sqlSession.delete(NAMESPACE+"delete", num);
	}

	@Override
	public int totalCount(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"totalCount", map);
	}

	@Override
	public void hitUpdate(int num, boolean flag) throws Exception {
		if(flag){ // view
			sqlSession.update(NAMESPACE+"hitPlus", num);
		}else{ // update
			sqlSession.update(NAMESPACE+"hitMinus", num);
		}
	}
	
}
