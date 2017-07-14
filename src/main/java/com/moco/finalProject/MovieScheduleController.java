package com.moco.finalProject;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.File;
import java.sql.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.moco.movieSchedule.MovieScheduleDTO;
import com.moco.movieSchedule.MovieScheduleService;
import com.moco.movieSchedule.MultipartFileSender;

@Controller
@RequestMapping(value="/movie/movieSchedule/**")
public class MovieScheduleController{
	
	@Autowired
	private MovieScheduleService movieScheduleService;
	private static final Logger logger = LoggerFactory.getLogger(MovieScheduleController.class);
	/*private static final String FILE_PATH = "/Final/resources/upload/adminMovieUpload";*/
	
	// 스트리밍
	 @RequestMapping(value = "movieStreaming", method = RequestMethod.GET)
	  public void getVideo(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
	    String filePath = request.getSession().getServletContext().getRealPath("resources/upload/adminMovieUpload");
	    System.out.println(filePath);
	    String fname = "";
	    String title = "";
	    // 데이터 조회
	    MovieScheduleDTO movieScheduleDTO = movieScheduleService.sysdateMovie();
	    if(movieScheduleDTO != null){
			fname = movieScheduleService.one1(movieScheduleDTO.getPnum());
			title = movieScheduleService.one2(movieScheduleDTO.getPnum());
			model.addAttribute("fname", fname);
			model.addAttribute("title", title);
		}
	    logger.info("동영상 스트리밍 요청 : " + filePath + fname);
	    
	    File getFile = new File(filePath,fname);
	  
	    try {
	      // 미디어 처리
	      MultipartFileSender
	        .fromFile(getFile)
	        .with(request)
	        .with(response)
	        .serveResource();
	      
	    } catch (Exception e) {
	      // 사용자 취소 Exception 은 콘솔 출력 제외
	      if (!e.getClass().getName().equals("org.apache.catalina.connector.ClientAbortException")) e.printStackTrace();
	    }
	  }
	//////////////////////////////////////////////// END STREAMING //////////////////////////////////////////////////////

	@RequestMapping(value="movieScheduleTable", method=RequestMethod.GET)
	public void movieScheduleTable(){
		
	}
	
	@RequestMapping(value="movieScheduleTableShow", method=RequestMethod.GET)
	@ResponseBody
	public List<MovieScheduleDTO> movieScheduleTableShow(Model model){		
		List<MovieScheduleDTO> ar = null;
		
		try {
			ar = movieScheduleService.movieScheduleShow();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ar;
	}
	
	@RequestMapping(value="movieScheduleList", method=RequestMethod.GET)
	public void movieScheduleList(Integer curPage, @RequestParam(required=false)String search, Model model){
		try {
			if(curPage == null){
				curPage = 1;
			}
			if(search == null){
				search="00000101";
			}
			
			Map<String, Object> map = movieScheduleService.movieScheduleList(curPage, search);
			model.addAttribute("list", map.get("list"));
			model.addAttribute("pageResult",map.get("pageResult"));
			model.addAttribute("curPage",curPage);
			model.addAttribute("search", search);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value="movieScheduleAdd", method=RequestMethod.GET)
	public void movieScheduleAdd() {
		
	}
	
	@RequestMapping(value="movieScheduleAdd", method=RequestMethod.POST)
	public String movieScheduleAdd(MovieScheduleDTO movieScheduleDTO, Integer curPage, @RequestParam(required=false)String search, Model model){
		try {
			movieScheduleService.movieScheduleAdd(movieScheduleDTO);

			if(curPage == null){
				curPage = 1;
			}
			if(search == null){
				search="00000101";
			}

			Map<String, Object> map = movieScheduleService.movieScheduleList(curPage, search);
			model.addAttribute("list", map.get("list"));
			model.addAttribute("pageResult",map.get("pageResult"));
			model.addAttribute("curPage",curPage);
			model.addAttribute("search", search);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "redirect:/movie/movieSchedule/movieScheduleList";
	}
	
	@RequestMapping(value="paidMovieCheck1", method=RequestMethod.POST)
	public String paidMovieCheck1(int pnum, Model model){
		String title = null;
		
		try {
			title = movieScheduleService.paidMovieCheck1(pnum);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(title == null){
			model.addAttribute("message", null);
		} else {
			model.addAttribute("message", title);
		}
		
		System.out.println("title : "+title);

		return "/movie/movieSchedule/action/movieSearchResult";
	}
	
	@RequestMapping(value="paidMovieCheck2", method=RequestMethod.POST)
	public String paidMovieCheck2(Date moviedate, Model model){
		Date date = null;
		
		try {
			date = movieScheduleService.paidMovieCheck2(moviedate);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(date == null){
			System.out.println("날짜가 중복되지 않습니다.");
		} else {
			System.out.println("날짜가 중복됩니다.");
		}

		model.addAttribute("message", date);
		System.out.println("Date : "+date);

		return "/movie/movieSchedule/action/movieSearchResult";
	}
	
	@RequestMapping(value="movieScheduleDelete", method=RequestMethod.POST)
	public String movieScheduleDelete(int num, Integer curPage, @RequestParam(required=false)String search, Model model){
		int result = 0;
		
		try {
			result = movieScheduleService.movieScheduleDelete(num);
			
			if(curPage == null){
				curPage = 1;
			}
			if(search == null){
				search="00000101";
			}
			
			Map<String, Object> map = movieScheduleService.movieScheduleList(curPage, search);
			model.addAttribute("list", map.get("list"));
			model.addAttribute("pageResult",map.get("pageResult"));
			model.addAttribute("curPage",curPage);
			model.addAttribute("search", search);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "/movie/movieSchedule/movieScheduleList";
	}
	
}
