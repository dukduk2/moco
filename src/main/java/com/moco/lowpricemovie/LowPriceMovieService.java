package com.moco.lowpricemovie;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moco.jjim.JjimDTO;
import com.moco.multiplex.MultiplexDAO;
import com.moco.multiplex.MultiplexDTO;
import com.moco.reservation.ReservationDAO;
import com.moco.reservation.ReservationDTO;
import com.moco.screen.ScreenDAO;
import com.moco.screen.ScreenDTO;
import com.moco.theater.TheaterDAO;
import com.moco.theater.TheaterDTO;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Service
public class LowPriceMovieService {
	
	@Autowired
	private LowPriceMovieDAO lowPriceMovieDAO;
	@Autowired
	private TheaterDAO theaterDAO;
	@Autowired
	private MultiplexDAO multiplexDAO;
	@Autowired
	private ScreenDAO screenDAO;
	@Autowired
	private ReservationDAO reservationDAO;
	
	//영화 LIST
	public Map<String, Object> list(int curPage, int perPage, String kind, String search) throws Exception{
		PageMaker pageMaker = new PageMaker(curPage, perPage);
		RowMaker rowMaker = pageMaker.getRowMaker();
		
		PageResult pageResult = pageMaker.paging(lowPriceMovieDAO.totalCount(kind, search));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", lowPriceMovieDAO.list(rowMaker, kind, search));
		map.put("pageResult", pageResult);
		
		return map;
	}
	//영화 VIEW
	public LowPriceMovieDTO view(int num) throws Exception{
		return lowPriceMovieDAO.view(num);
	}
	//영화 delete
	public int delete(int num) throws Exception{
		return lowPriceMovieDAO.delete(num);
	}
	//영화 insert
	public int insert(LowPriceMovieDTO lowPriceMovieDTO) throws Exception{
		return lowPriceMovieDAO.insert(lowPriceMovieDTO);
	}
	//영화 update
	public int update(LowPriceMovieDTO lowPriceMovieDTO) throws Exception{
		return lowPriceMovieDAO.update(lowPriceMovieDTO);
	}
	//극장 LIST
	public Map<String, Object> theaterList(int curPage, int perPage, String kind, String search) throws Exception{
		PageMaker pageMaker = new PageMaker(curPage, perPage);
		RowMaker rowMaker = pageMaker.getRowMaker();
		
		PageResult pageResult = pageMaker.paging(theaterDAO.totalCount(kind, search));
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", theaterDAO.list(rowMaker, kind, search));
		map.put("pageResult", pageResult);
		
		return map;
	}
	//commitList
	public Map<String, Object> theaterList(int curPage, int perPage) throws Exception{
		PageMaker pageMaker = new PageMaker(curPage, perPage);
		RowMaker rowMaker = pageMaker.getRowMaker();
		
		PageResult pageResult = pageMaker.paging(theaterDAO.totalCount());
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("list", theaterDAO.list(rowMaker));
		map.put("pageResult", pageResult);
		
		return map;
	}
	public int theaterUncommitCount() throws Exception{
		return theaterDAO.totalCount();
	}
	//해당 극장의 상영관 LIST
	public List<MultiplexDTO> multiplexList(int theater_num) throws Exception{
		return multiplexDAO.list(theater_num);
	}
	//상영관 등록신청( 극장과 상영관 )
	public int theaterRequest(TheaterDTO theaterDTO, MultiplexDTO multiplexDTO) throws Exception{
		return theaterDAO.insert(theaterDTO, multiplexDTO);
	}
	//상영관 VIEW(NUM필드로)
	public MultiplexDTO multiplexView(int num) throws Exception{
		return multiplexDAO.view(num);
	}
	//극장 VIEW
	public TheaterDTO theaterView(int num) throws Exception{
		return theaterDAO.view(num);
	}
	//영화를 상영관에서 틀고싶다고 등록신청
	public void theaterInsert(int movie_num, Integer[] multi_num, Date[] start_date, Date[] end_date) throws Exception{
		//상영하려는 영화는 다 똑같으므로.
		LowPriceMovieDTO lowPriceMovieDTO = this.view(movie_num);
		
		//극장 구하기 위한 MultiplexDTO = 어떤 상영관이라도 극장은 같다를 이용.
		MultiplexDTO commonMultiplexDTO = this.multiplexView(multi_num[0]);
		TheaterDTO theaterDTO = this.theaterView(commonMultiplexDTO.getTheater_num());
		
		//상영관 숫자만큼 for문 돌려야하니까.
		//근데 상영관 선택한것당 start_date랑 end_date니까. gab은 그 상영관에서의 상영일수.
		for(int i=0 ; i<multi_num.length ; i++){
			//이걸 굳이 계속 돌릴필요가 없는데. 왜냐면 theater마다 상영시간은 다 동일하게 주기로 했으니!
			//근데 24시까지 마친것을 알 기준이 필요한데 그걸 date의 일로 잡아서...
			//다른 방법 있으면 변경 ㄱㄱ
			List<Integer> time = new ArrayList<Integer>(); 
			time = this.timeCal(start_date[i], theaterDTO.getOpening_time(), lowPriceMovieDTO.getPlay_time());
			int available_seat = (this.multiplexView(multi_num[i])).getTotalseat();
			
			long s_date = start_date[i].getTime();
			long e_date = end_date[i].getTime();
			int gab = (int)((e_date - s_date)/24/60/60/1000);
			
			Calendar ca = Calendar.getInstance();
			//상영시작일 세팅
			ca.setTime(start_date[i]);
			
			List<ScreenDTO> ar = new ArrayList<ScreenDTO>();
			
			ScreenDTO screenDTO = null;
			
			//상영일수 만큼 for문 돌려야하니까.
			//27일 28일 선택하면. gab = 1, 2번 들어가야하므로 gab+1
			for(int j=0; j<gab+1 ; j++){
				screenDTO = new ScreenDTO();
				screenDTO.setMulti_num(multi_num[i]);
				screenDTO.setMovie_num(movie_num);
				//배열인덱스 증가가 아니라 배열값의 +1 증가.
				screenDTO.setShow_date(Date.valueOf(this.toString(ca)));
				screenDTO.setAvailable_seat(available_seat);
				screenDTO.setCommit(0);
				
				//상영시간수만큼 for문 돌려야하니까.
				//screenDTO에 시간 세팅
				for(int k=0 ; k<time.size() ; k++){
					screenDTO.setHour(time.get(k));
					screenDTO.setMinute(time.get(k+1));
					k++;
					
					screenDAO.insert(screenDTO);
				}
				ca.add(Calendar.DATE, 1);
			}
		}

	}
	private List<Integer> timeCal(Date show_date, String opening_time, String play_time){
		//영화 상영시간
		play_time = play_time.substring(0, play_time.lastIndexOf("분"));
		int playing_time = Integer.parseInt(play_time);
		int break_time = 10;
		//상영관 영화 첫 상영시간
		//시
		int opening_h = Integer.parseInt(opening_time.substring(0, 2));
		//분
		int opening_m = Integer.parseInt(opening_time.substring(3, 5));
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd일HH:mm");
		//시간 더하기
		Calendar ca = Calendar.getInstance();
		ca.setTime(show_date);
		
		ca.set(Calendar.HOUR_OF_DAY, opening_h);
		ca.set(Calendar.MINUTE, opening_m);
		
		String time = null;
		time = sdf.format(ca.getTime());
		
		int today = Integer.parseInt(time.substring(0, 2));
		int hour = Integer.parseInt(time.substring(3, 5));
		int minute = Integer.parseInt(time.substring(6, 8));
		
		//첫 상영시간 세팅
		List<Integer> ar = new ArrayList<Integer>();
		ar.add(hour);
		ar.add(minute);
		
		//영화시간 + 쉬는시간 만큼 더한 상영시간 세팅
		for(int i=0 ; i<24 ; i++){
			ca.add(Calendar.MINUTE, playing_time+break_time);
			time = sdf.format(ca.getTime());
			
			int tomorrow = Integer.parseInt(time.substring(0,2));
			if(today < tomorrow){
				break;
			}
			hour = Integer.parseInt(time.substring(3, 5));
			minute = Integer.parseInt(time.substring(6, 8));
			
			ar.add(hour);
			ar.add(minute);
		}
		return ar;
	}
	//상영시작~종료일시 돌릴때 필요한 메서드
	private String toString(Calendar ca){
		String str = ca.get(Calendar.YEAR)+"-"+(ca.get(Calendar.MONTH)+1)+"-"+ca.get(Calendar.DATE);

		return str;
	}
	public List<ScreenDTO> screenList(int multi_num) throws Exception{
		return screenDAO.list(multi_num);
	}
	
	//프로시저 사용.(reservation db insert & screen db update)
	public int reservationInsert(ReservationDTO reservationDTO) throws Exception{
		return reservationDAO.insert(reservationDTO);
	}
	
	
	// 찜하기 확인
	public JjimDTO jjimCheck(JjimDTO jjimDTO) throws Exception{
		return lowPriceMovieDAO.jjimCheck(jjimDTO);
	}
	// 찜하기 INSERT
	public int jjimInsert(JjimDTO jjimDTO) throws Exception{
		return lowPriceMovieDAO.jjimInsert(jjimDTO);
	}
	// 찜하기 DELETE
	public int jjimDelete(JjimDTO jjimDTO) throws Exception{
		return lowPriceMovieDAO.jjimDelete(jjimDTO);
	}
	
	public int theaterCommitUpdate(int num) throws Exception{
		return theaterDAO.commitUpdate(num);
	}
	
	
}
