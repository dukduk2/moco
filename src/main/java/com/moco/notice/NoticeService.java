package com.moco.notice;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class NoticeService {

	@Inject
	private NoticeDAO noticeDAO;
	
	public List<NoticeDTO> noticeList(Map<String, Object> map) throws Exception{
		return noticeDAO.noticeList(map);
	}
	
	public int totalCount() throws Exception{
		return noticeDAO.totalCount();
	}
	
	public NoticeDTO noticeView(int num) throws Exception{
		return noticeDAO.noticeView(num);
	}
	
	public int noticeInsert(NoticeDTO noticeDTO) throws Exception{
		return noticeDAO.noticeInsert(noticeDTO);
	}
	
	public int noticeUpdate(NoticeDTO noticeDTO) throws Exception{
		return noticeDAO.noticeUpdate(noticeDTO);
	}
	
	public int noticeDelete(int num) throws Exception{
		return noticeDAO.noticeDelete(num);
	}
	
	public int hitUpdate(boolean check, int num) throws Exception{
		return noticeDAO.hitUpdate(check, num);
	}
	
	
}
