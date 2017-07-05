package com.moco.finalProject;

import java.io.File;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.moco.agency.AgencyDTO;
import com.moco.agency.AgencyService;
import com.moco.fileTest.FileSaver;
import com.moco.member.MemberDTO;
import com.moco.member.MemberService;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieRequest.MovieRequestDTO;
import com.moco.movieRequest.MovieRequestService;
import com.moco.movieSchedule.MovieScheduleDTO;
import com.moco.movieSchedule.MovieScheduleService;
import com.moco.paidMovie.PaidMovieDTO;
import com.moco.paidMovie.PaidMovieService;
import com.moco.season.SeasonDTO;
import com.moco.season.SeasonService;
import com.moco.userBoard.UserBoardService;
import com.moco.util.PageMaker;
import com.moco.util.PageResult;
import com.moco.util.RowMaker;

@Controller
@RequestMapping(value="/admin/")
public class AdminController {

	@Inject
	private UserBoardService userBoardService;
	@Inject
	private SeasonService seasonService;
	@Inject
	private PaidMovieService paidMovieService; 
	@Inject
	private AgencyService agencyService;
	@Inject
	private MemberService memberService;
	@Inject
	private MovieRequestService movieRequestService;
	@Inject
	private MovieScheduleService movieScheduleService;

	// index
	@RequestMapping(value="index" , method=RequestMethod.GET)
	public void index(Model model) throws Exception{
		// userCommit - 대기중
		model.addAttribute("userBoardCommitCount", userBoardService.adminIndexCount());
		// memberList - 대기중
		model.addAttribute("memberStateCount", memberService.adminStateCount());
		// 배급사 신청 - 대기중
		model.addAttribute("agencyCommitCount", agencyService.agencyUncommitCount());
		// movieRequest - 요청 중
		model.addAttribute("movieRequest", movieRequestService.movieRequestTotalCount());
	}

	// movieRequest
	@RequestMapping(value="movieRequestList",method=RequestMethod.GET)
	public void movieRequest(Integer curPage, Model model) throws Exception{
		if(curPage == null){
			curPage = 1;
		}
		// list
		List<BasicMovieDTO> ar = movieRequestService.movieRequestList(curPage);
		model.addAttribute("movieRequestList", ar);
		// 페이징
		PageMaker pageMaker = new PageMaker(curPage, 10);
		PageResult pageResult = pageMaker.paging(movieRequestService.movieRequestTotalCount());
		model.addAttribute("pageResult", pageResult);
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// movieUpload
	@RequestMapping(value="movieUpload",method=RequestMethod.GET)
	public void movieUpload(Integer movieNum, String movieTitle, Integer curPage, String search, HttpSession session, Model model) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(curPage == null){
			curPage = 1;
		}
		if(search == null){
			search = "%%%";
		}
		
		// movieRequest에서 영화Upload로 넘어갈 때
		if(movieNum == null){
			movieNum = 0;
		}
		if(movieTitle == null){
			movieTitle = "%";
		}

		RowMaker rowMaker = new RowMaker();
		rowMaker.makeRow(curPage, 10);
		map.put("row", rowMaker);
		map.put("search", search);
		map.put("curPage", curPage);
		
		// pageing
		PageMaker pageMaker = new PageMaker(curPage);
		int totalCount = paidMovieService.movieTotalCount(search);
		PageResult pageResult = pageMaker.paging(totalCount);

		model.addAttribute("pageResult", pageResult);
		model.addAttribute("map", map);

		// Upload한 movies
		List<PaidMovieDTO> ar = paidMovieService.movieList(map);
		model.addAttribute("fileList", ar);
		
		// movieNum & movieTitle
		model.addAttribute("movieNum", movieNum);
		model.addAttribute("movieKind", paidMovieService.kindFind(movieTitle, movieNum));
		
	}
	// movieUploadInsert
	@RequestMapping(value="movieUpload", method=RequestMethod.POST)
	public String movieUploadInsert(HttpSession session, PaidMovieDTO paidMovieDTO, String movieKind, int movieNum, @RequestParam(value="movie") MultipartFile multipartFile) throws Exception{
		String path = session.getServletContext().getRealPath("resources/upload/adminMovieUpload");
		// DTO 셋팅
		paidMovieDTO = paidMovieService.DTOSet(paidMovieDTO, movieKind, movieNum);
		// oname Set
		paidMovieDTO.setOname(multipartFile.getOriginalFilename());
		File f = new File(path);
		if(!f.exists()){
			f.mkdirs();
		}

		// upload & fname Set
		FileSaver fileSaver = new FileSaver();
		paidMovieDTO.setFname(fileSaver.saver(multipartFile, path));

		// DB
		paidMovieService.movieInsert(paidMovieDTO);
		
		// 만일, movieRequest를 타고 와서 upload를 했을 시에는 movieRequestTable에서 삭제해 주어야 함.
		paidMovieService.movieRequestDelete(paidMovieDTO);
		
		return "redirect:/admin/movieUpload";
	}
	// delete
	@RequestMapping(value="movieDelete", method=RequestMethod.POST)
	public String movieDelete(HttpSession session, String fileName) throws Exception{
		// upload 삭제
		String path = session.getServletContext().getRealPath("resources/upload/adminMovieUpload");
		FileSaver fileSaver = new FileSaver();
		fileSaver.fileDelete(path, fileName);
		// DB에서 삭제
		paidMovieService.movieDelete(fileName);
		return "redirect:/admin/movieUpload";
	}
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	// scheduler
	@RequestMapping(value="scheduler", method=RequestMethod.GET)
	public void scheduler(){
		
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// SEASON
	@RequestMapping(value="adminSeason",method=RequestMethod.GET)
	public void adminSeason(Model model) throws Exception{
		int perPage = 3;
		
		// user
		PageMaker upageMaker = new PageMaker(1, perPage);
		PageResult upageResult = upageMaker.paging(seasonService.seasonTotalCount("user"));
		model.addAttribute("userSeason", seasonService.adminOrderSelect2(1, perPage, "user"));
		model.addAttribute("upageResult", upageResult);

		// actor
		PageMaker apageMaker = new PageMaker(1, perPage);
		PageResult apageResult = apageMaker.paging(seasonService.seasonTotalCount("actor"));
		model.addAttribute("actorSeason", seasonService.adminOrderSelect2(1, perPage, "actor"));
		model.addAttribute("apageResult", apageResult);
	}
	@RequestMapping(value="userSeasonList", method=RequestMethod.GET)
	public void userSeasonList(Integer curPage, Model model) throws Exception{
		int perPage = 3;
		model.addAttribute("userSeason", seasonService.adminOrderSelect2(curPage, perPage, "user"));
	}
	
	@RequestMapping(value="actorSeasonList", method=RequestMethod.GET)
	public void actorSeasonList(Integer curPage, Model model) throws Exception{
		int perPage = 3;
		model.addAttribute("actorSeason", seasonService.adminOrderSelect2(curPage, perPage, "actor"));
	}
	@RequestMapping(value="adminSeasonInsert", method=RequestMethod.POST)
	public String adminSeasonInsert(SeasonDTO seasonDTO) throws Exception{
		seasonService.adminOrderInsert(seasonDTO);
		return "redirect:adminSeason";
	}
	@RequestMapping(value="adminSeasonStart", method=RequestMethod.POST)
	public String adminSeasonStart(int num) throws Exception{
		seasonService.adminOrderStart(num);
		return "redirect:adminSeason";
	}
	@RequestMapping(value="adminSeasonEnd", method=RequestMethod.POST)
	public String adminSeasonEnd(int num) throws Exception{
		seasonService.adminOrderEnd(num);
		return "redirect:adminSeason";
	}
	@RequestMapping(value="adminSeasonDelete", method=RequestMethod.POST)
	public String adminSeasonDelete(int num) throws Exception{
		seasonService.adminOrderDelete(num);
		return "redirect:adminSeason";
	}

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// userBoardCommit
	@RequestMapping(value="userBoardCommit", method=RequestMethod.GET)
	public void userBoardCommit(String season, Integer curPage, Integer perPage, String kind, String search, Model model) throws Exception{
		// userCommit
		if(season == null){
			season = "%";
		}
		if(season.equals("all")){
			season = "%";
		}
		if(curPage == null){
			curPage = 1;
		}
		if(perPage == null){
			perPage = 10;
		}
		if(kind == null){
			kind = "title";
		}
		if(search == null){
			search = "%";
		}

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("season", season);
		map.put("curPage", curPage);
		map.put("perPage", perPage);
		map.put("kind", kind);
		map.put("search", search);

		RowMaker rowMaker = new RowMaker();
		rowMaker.makeRow(curPage, perPage);

		map.put("startRow", rowMaker.getStartRow());
		map.put("lastRow", rowMaker.getLastRow());

		// pageing

		PageMaker pageMaker = new PageMaker(curPage);

		int totalCount = userBoardService.adminTotalCount(map);
		PageResult pageResult = pageMaker.paging(totalCount);

		model.addAttribute("map", map);
		model.addAttribute("pageResult", pageResult);

		model.addAttribute("list", userBoardService.adminCommitSelect(map));
		// 관리자가 order(회차) 를 내리면 db에서 읽어온다.
		List<SeasonDTO> ar = seasonService.adminOrderSelect("user");
		model.addAttribute("orderList", ar);
	}

	@RequestMapping(value="userBoardView", method=RequestMethod.POST)
	public String userBoardView(int num, Model model) throws Exception{
		// Ajax - View
		model.addAttribute("UserBoardDTO", userBoardService.view(num));
		return "admin/commitBoardView";
	}

	@RequestMapping(value="userBoardCommit",method=RequestMethod.POST)
	public String userBoardCommit(int num) throws Exception{
		// commitUpdate
		userBoardService.adminCommitUpdate(num);
		// redirect 
		return "redirect:/admin/userBoardCommit";
	}

	@RequestMapping(value="userBoardRefuse", method=RequestMethod.POST)
	public String userBoardRefuse(int num, HttpSession session) throws Exception{
		// DB에서 글 삭제 && Upload 삭제
		userBoardService.delete(num, session);
		return "redirect:/admin/userBoardCommit";
	}

	/////////////////////////////////////////////////////////////////////////////////////////////////
	//agencyRequest
	
	@RequestMapping(value="agencyDelete", method=RequestMethod.GET)
	public void agencyDelete() throws Exception{

	}
	
	@RequestMapping(value="agencyDelete", method=RequestMethod.POST)
	public String agencyDelete(int num) throws Exception{
		int result=0;
		result=agencyService.agencyDelete(num);
		
		return "redirect:/admin/agencyList";
	}

	@RequestMapping(value="agencyCommit", method=RequestMethod.GET)
	public void agencyCommit() throws Exception{

	}

	@RequestMapping(value="agencyCommit", method=RequestMethod.POST)
	public String agencyCommit(int num) throws Exception{
		int result=agencyService.agencyCommit(num);
		return "redirect:/admin/agencyList";
	}

	@RequestMapping(value="agencyCommitCancel", method=RequestMethod.GET)
	public void agencyCommitCancel() throws Exception{

	}

	@RequestMapping(value="agencyCommitCancel", method=RequestMethod.POST)
	public String agencyCommitCancel(int num) throws Exception{
		int result=agencyService.agencyCommitCancel(num);
		return "redirect:/admin/agencyList";
	}

	@RequestMapping(value="agencyView", method=RequestMethod.GET)
	public void agencyView(int num, Model model) throws Exception{
		AgencyDTO agencyDTO=new AgencyDTO();
		agencyDTO=agencyService.agencyView(num);
		model.addAttribute("dto", agencyDTO);
	}

	@RequestMapping(value="agencyList", method=RequestMethod.GET)
	public void agencyList(Integer curPage1, Integer curPage2, Integer perPage, Model model) throws Exception{
		Map<String, Object> map1=new HashMap<String, Object>(); //승인o
		Map<String, Object> map2=new HashMap<String, Object>(); //승인x
		/*List<AgencyDTO> ar=agencyService.agencyList(map);
		model.addAttribute("list", ar);*/
		if(curPage1==null){
			curPage1=1; //승인된 페이지
		}
		if(curPage2==null){
			curPage2=1; //승인되지않은 페이지
		}
		if(perPage==null){
			perPage=5;
		}
		
		map1.put("curPage1", curPage1);
		map1.put("perPage", perPage);
		
		map2.put("curPage2", curPage2);
		map2.put("perPage", perPage);
		
		RowMaker rowMaker1=new RowMaker();
		rowMaker1.makeRow(curPage1, perPage);
		
		RowMaker rowMaker2=new RowMaker();
		rowMaker2.makeRow(curPage2, perPage);
		
		map1.put("startRow1", rowMaker1.getStartRow());
		map1.put("lastRow1", rowMaker1.getLastRow());
		
		map2.put("startRow2", rowMaker2.getStartRow());
		map2.put("lastRow2", rowMaker2.getLastRow());
		
		PageMaker pageMaker1=new PageMaker(curPage1,perPage);
		int totalCount1=agencyService.agencyCommitCount(map1); //승인된 게시물 수
		PageResult pageResult1=pageMaker1.paging(totalCount1);
		
		PageMaker pageMaker2=new PageMaker(curPage2,perPage);
		int totalCount2=agencyService.agencyUncommitCount(); //승인된 게시물 수
		PageResult pageResult2=pageMaker2.paging(totalCount2);
		
		List<AgencyDTO> ar1=agencyService.agencyCommitList(map1);
		List<AgencyDTO> ar2=agencyService.agencyUncommitList(map2);
		
		model.addAttribute("map1", map1);
		model.addAttribute("map2", map2);
		model.addAttribute("pageResult1", pageResult1);
		model.addAttribute("pageResult2", pageResult2);
		model.addAttribute("list1", ar1);
		model.addAttribute("list2", ar2);
		model.addAttribute("totalCount1", totalCount1);
		model.addAttribute("totalCount2", totalCount2);
	}
	
	@RequestMapping(value="agencyCommitList", method=RequestMethod.GET)
	public void agencyCommitList(Integer curPage, Integer perPage, Model model) throws Exception{
		Map<String, Object> map=new HashMap<String, Object>();
		
		if(curPage==null){
			curPage=1;
		}
		if(perPage==null){
			perPage=5;
		}
		map.put("curPage", curPage);
		map.put("perPage", perPage);
		
		RowMaker rowMaker=new RowMaker();
		rowMaker.makeRow(curPage, perPage);
		
		map.put("startRow1", rowMaker.getStartRow());
		map.put("lastRow1", rowMaker.getLastRow());
		
		PageMaker pageMaker=new PageMaker(curPage,perPage);
		int totalCount=agencyService.agencyCommitCount(map); //승인된 게시물 수
		PageResult pageResult=pageMaker.paging(totalCount);
		
		List<AgencyDTO> ar=agencyService.agencyCommitList(map);
		
		model.addAttribute("map", map);
		model.addAttribute("pageResult1", pageResult);
		model.addAttribute("list", ar);
		model.addAttribute("totalCount1", totalCount);

	}
	
	@RequestMapping(value="agencyUncommitList", method=RequestMethod.GET)
	public void agencyUncommitList(Integer curPage, Integer perPage, Model model) throws Exception{
		Map<String, Object> map=new HashMap<String, Object>();
		
		if(curPage==null){
			curPage=1;
		}
		if(perPage==null){
			perPage=5;
		}
		map.put("curPage", curPage);
		map.put("perPage", perPage);
		
		RowMaker rowMaker=new RowMaker();
		rowMaker.makeRow(curPage, perPage);
		
		map.put("startRow2", rowMaker.getStartRow());
		map.put("lastRow2", rowMaker.getLastRow());
	
		
		PageMaker pageMaker=new PageMaker(curPage,perPage);
		int totalCount=agencyService.agencyUncommitCount(); //승인된 게시물 수
		PageResult pageResult=pageMaker.paging(totalCount);
		
		List<AgencyDTO> ar=agencyService.agencyUncommitList(map);
		
		model.addAttribute("map", map);
		model.addAttribute("pageResult", pageResult);
		model.addAttribute("list", ar);
		model.addAttribute("totalCount", totalCount);

	}

	/////////////////////////////////////////////////////////////////////////////////////////////////
	// Member
	//관리자가 멤버 리스트 불러들임
	@RequestMapping(value="memberList", method=RequestMethod.GET)
	public String MemberList(Integer curPage, @RequestParam(required=false)String kind, @RequestParam(required=false)String search, Model model){
		try {
			if(kind == null){
				kind="%";
			}
			if(curPage == null){
				curPage = 1;
			}
			if(search == null){
				search="%";
			}

			Map<String, Object> map = memberService.memberList(curPage, kind, search);
			model.addAttribute("list", map.get("list"));
			model.addAttribute("pageResult",map.get("pageResult"));
			model.addAttribute("curPage",curPage);
			model.addAttribute("search", search);
			model.addAttribute("kind", kind);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "/admin/memberList";
	}

	//관리자가 delete
	@RequestMapping(value="managementDelete", method=RequestMethod.POST)
	public String managementDelete(String id, HttpSession session, Integer curPage, @RequestParam(required=false)String kind, @RequestParam(required=false)String search, Model model){
		System.out.println("- MemberController -> managementDelete");

		String message = "Member Delete Fail";
		int result = 0;

		try {
			result = memberService.memberDelete(id);

			//memberManagement 내용
			if(kind == null){
				kind="id";
			}
			if(curPage == null){
				curPage = 1;
			}
			if(search == null){
				search="%";
			}

			Map<String, Object> map = memberService.memberList(curPage, kind, search);
			model.addAttribute("list", map.get("list"));
			model.addAttribute("pageResult",map.get("pageResult"));
			model.addAttribute("curPage",curPage);
			model.addAttribute("search", search);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if(result>0){
			message = "Member Delete Success";
		}

		session.setAttribute("memberDTO", (MemberDTO)session.getAttribute("memberDTO"));
		return "/admin/memberList";
	}

	//관리자가 멤버 수정
	@RequestMapping(value="managementUpdate", method=RequestMethod.POST)
	public String managementUpdate(MemberDTO memberDTO, HttpSession session, Integer curPage, @RequestParam(required=false)String kind, @RequestParam(required=false)String search, Model model){
		System.out.println("- MemberController -> managementUpdate");

		String message = "Member Update Fail";
		int result = 0;

		try {
			result = memberService.managementUpdate(memberDTO);

			//memberManagement 내용
			if(kind == null){
				kind="id";
			}
			if(curPage == null){
				curPage = 1;
			}
			if(search == null){
				search="%";
			}

			Map<String, Object> map = memberService.memberList(curPage, kind, search);
			model.addAttribute("list", map.get("list"));
			model.addAttribute("pageResult",map.get("pageResult"));
			model.addAttribute("curPage",curPage);
			model.addAttribute("search", search);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if(result>0){
			message = "Member Update Success";
		}

		session.setAttribute("memberDTO", (MemberDTO)session.getAttribute("memberDTO"));

		return "/admin/memberList";
	}
	
	//무비 스케쥴
	@RequestMapping(value="movieScheduleList", method=RequestMethod.GET)
	public String movieScheduleList(Integer curPage, @RequestParam(required=false)String search, Model model){
		System.out.println("- movieScheduleController -> ListShow");
		
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
		
		return "/admin/movieScheduleList";
	}
	
	@RequestMapping(value="movieScheduleAdd", method=RequestMethod.GET)
	public void movieScheduleAdd() {
		System.out.println("- movieScheduleController -> Add1");
	}
	
	@RequestMapping(value="movieScheduleAdd", method=RequestMethod.POST)
	public String movieScheduleAdd(MovieScheduleDTO movieScheduleDTO, Integer curPage, @RequestParam(required=false)String search, Model model){
		System.out.println("- movieScheduleController -> Add2");

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

		return "redirect:/admin/movieScheduleList";
	}
	
	@RequestMapping(value="paidMovieCheck1", method=RequestMethod.POST)
	public String paidMovieCheck1(int pnum, Model model){
		System.out.println("- movieScheduleController -> paidMovieCheck1");
		
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

		return "/admin/action/movieSearchResult";
	}
	
	@RequestMapping(value="paidMovieCheck2", method=RequestMethod.POST)
	public String paidMovieCheck2(Date moviedate, Model model){
		System.out.println("- movieScheduleController -> paidMovieCheck2");
		
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

		return "/admin/action/movieSearchResult";
	}
	
	@RequestMapping(value="movieScheduleDelete", method=RequestMethod.POST)
	public String movieScheduleDelete(int num, Integer curPage, @RequestParam(required=false)String search, Model model){
		System.out.println("- movieScheduleController -> movieScheduleDeleteS");

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

		return "/admin/action/ScheduleListResult";
	}
}
