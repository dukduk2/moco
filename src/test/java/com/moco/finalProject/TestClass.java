package com.moco.finalProject;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.moco.multiplex.MultiplexDAO;
import com.moco.multiplex.MultiplexDTO;
import com.moco.screen.ScreenDAO;
import com.moco.screen.ScreenDTO;
import com.moco.theater.TheaterDAO;
import com.moco.theater.TheaterDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class TestClass {

	@Autowired
	private ScreenDAO screenDAO;
	@Autowired
	private MultiplexDAO multiplexDAO;
	@Autowired
	private TheaterDAO theaterDAO;
	@Test
	public void test() throws Exception{
		List<ScreenDTO> ar = screenDAO.unCommitList();
		
		List<Integer> mnums = new ArrayList<Integer>();
		
		for(int i=0;i<ar.size();i++){
			mnums.add(ar.get(i).getMulti_num());
			System.out.println(mnums.get(i));
		}
		List<Integer> uniqueItems = new ArrayList<Integer>(new HashSet<Integer>(mnums));
		
		
		
		System.out.println(uniqueItems);
		
		List<TheaterDTO> ar3 = new ArrayList<TheaterDTO>();
		
		for(int i=0; i<uniqueItems.size(); i++){
			System.out.println(uniqueItems.get(i));
			MultiplexDTO multiplexDTO = multiplexDAO.unCommitList(uniqueItems.get(i));
			System.out.println("multiPlEX : "+multiplexDTO.getTheater_num());
			TheaterDTO theaterDTO = theaterDAO.view(multiplexDTO.getTheater_num());
			ar3.add(theaterDTO);
		}
		
		for (TheaterDTO theaterDTO : ar3) {
			System.out.println(theaterDTO.getName());
		}
		List<TheaterDTO> uniqueTheater = new ArrayList<TheaterDTO>(new HashSet<TheaterDTO>(ar3));
		
		System.out.println(uniqueTheater);
		for (TheaterDTO theaterDTO : uniqueTheater) {
			System.out.println(theaterDTO.getName());
		}
	}
	
}


