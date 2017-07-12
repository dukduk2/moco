package com.moco.finalProject;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.ArrayList;
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

	@Test
	public void test() throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", "admin");
		RowMaker rowMaker = new RowMaker();
		rowMaker.makeRow(1, 10);
		map.put("row", rowMaker);
		List<PointDTO >ar = pointDAO.pointList(map);
		for (PointDTO pointDTO : ar) {
			System.out.println("be:"+pointDTO.getBenefit());
		}
		assertNotNull(ar);
		
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



