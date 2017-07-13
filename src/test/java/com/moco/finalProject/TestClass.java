package com.moco.finalProject;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moco.movieSchedule.MovieScheduleDAO;
import com.moco.multiplex.MultiplexDAO;
import com.moco.multiplex.MultiplexDTO;
import com.moco.point.PointDAO;
import com.moco.point.PointDTO;
import com.moco.screen.ScreenDAO;
import com.moco.screen.ScreenDTO;
import com.moco.theater.TheaterDAO;
import com.moco.theater.TheaterDTO;
import com.moco.util.RowMaker;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class TestClass {

	@Autowired
	private ScreenDAO screenDAO;
	@Autowired
	private MultiplexDAO multiplexDAO;
	@Autowired
	private TheaterDAO theaterDAO;
	@Inject
	private PointDAO pointDAO;
	@Inject
	private MovieScheduleDAO movieScheduleDAO;

	@Test
	public void test() throws Exception{
		
		Date date = new Date();
		System.out.println(date.getTime());
		// 1초 1000, 1분 60000, 1시간 3600000, 20시간 28800000
		// 크론으로 19:59분에 롱타입 + long = totalTime
		// startTime 19:59 long, totalTime
		// nowTime boolean true, false
		// !!!!스트리밍!!!!
		/*String play_Time = movieScheduleDAO.getPlayTime(816);
		System.out.println(play_Time);
		int playTime = 0;
		play_Time = play_Time.substring(0,play_Time.indexOf("분"));
		System.out.println(play_Time);
		playTime = Integer.parseInt(play_Time);
		System.out.println(playTime);
		System.out.println("========================");
		Date date = new Date();
		long now = date.getTime();
		System.out.println(now);
		long play = playTime*60*1000;
		System.out.println(play);
		long total = now+play;
		System.out.println(total);
		int h = date.getHours();
		System.out.println(h);*/
	}
	/*@Test
	public void test() throws Exception{
		int theater_num = 1;

		List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();


		TheaterDTO theaterDTO = theaterDAO.view(theater_num);

		List<MultiplexDTO> ar = multiplexDAO.list(theater_num);

		for(MultiplexDTO multiplexDTO : ar){
			Map<String, Object> map = new HashMap<String, Object>();
			List<ScreenDTO> screenList = screenDAO.unCommitListMultiNum(multiplexDTO.getNum());
			map.put("multiplexDTO", multiplexDTO);
			map.put("screenList", screenList);
			result.add(map);
		}

		for(int i=0 ; i<result.size() ; i++){
			System.out.println(((MultiplexDTO)result.get(i).get("multiplexDTO")).getName());
			List<ScreenDTO> sc = (List<ScreenDTO>) result.get(i).get("screenList");

			for(int j=0; j<sc.size(); j++){
				System.out.println(sc.get(j).getHour());
			}
		}
	 */


}



