package com.moco.directorBoard;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.moco.board.BoardDTO;
import com.moco.board.BoardService;

@Service
public class DirectorBoardService implements BoardService {
	@Inject
	DirectorBoardDAO directorBoardDAO;
	
	@Override
	public List<BoardDTO> list(Map<String, Object> map) throws Exception {
		return directorBoardDAO.list(map);
	}

	@Override
	public BoardDTO view(int num) throws Exception {
		return directorBoardDAO.view(num);
	}

	@Override
	public int write(BoardDTO boardDTO) throws Exception {
		return directorBoardDAO.write(boardDTO);
	}

	@Override
	public int update(BoardDTO boardDTO) throws Exception {
		return directorBoardDAO.update(boardDTO);
	}

	@Override
	public int totalCount(Map<String, Object> map) throws Exception {
		return directorBoardDAO.totalCount(map);
	}

	@Override
	public void hitUpdate(int num, boolean flag) throws Exception {
		directorBoardDAO.hitUpdate(num, flag);
	}
	
	public int stateUpdate() throws Exception{
		return directorBoardDAO.stateUpdate();
	}
	
	public List<DirectorBoardDTO> compareDate() throws Exception{
		return directorBoardDAO.compareDate();
	}
	
	public int stateUpdateFinish(int num) throws Exception{
		return directorBoardDAO.stateUpdateFinish(num);
	}

	@Override
	public int delete(int num, HttpSession session) throws Exception {
		return directorBoardDAO.delete(num);
	}

}
