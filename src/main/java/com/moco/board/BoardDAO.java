package com.moco.board;

import java.util.List;
import java.util.Map;

public interface BoardDAO {

	// list
	public abstract List<BoardDTO> list(Map<String, Object> map) throws Exception;
	// view
	public abstract BoardDTO view(int num) throws Exception;
	// write
	public abstract int write(BoardDTO boardDTO) throws Exception;
	// update
	public abstract int update(BoardDTO boardDTO) throws Exception;
	// delete
	public abstract int delete(int num) throws Exception;
	// totalCount
	public abstract int totalCount(Map<String, Object> map) throws Exception;
	// hitupdate
	public abstract void hitUpdate(int num, boolean flag) throws Exception;
	
}
