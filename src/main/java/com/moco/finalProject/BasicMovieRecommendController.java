package com.moco.finalProject;

import java.lang.reflect.Member;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.moco.member.MemberDTO;
import com.moco.movieAPI.BasicMovieDTO;
import com.moco.movieAPI.movieRecommend.RecommendService;
import com.moco.movieAPI.movieRecommend.subDTO.AgeViewDTO;
import com.moco.movieAPI.movieRecommend.subDTO.DirectorDTO;
import com.moco.movieAPI.movieRecommend.subDTO.JjimRankDTO;
import com.moco.movieAPI.movieRecommend.subDTO.ReviewRankDTO;
import com.moco.movieAPI.movieRecommend.weather.Getweather;
import com.moco.viewCheck.ViewCheckService;

@Controller
@RequestMapping(value="/movie/basicMovieSearch/movieRecommend/")
public class BasicMovieRecommendController {
	
	@Inject
	RecommendService recommendService;
	@Inject
	ViewCheckService viewCheckService;
	
	@RequestMapping(value="recommendHome", method=RequestMethod.GET)
	public void recommendHome(){
		
	}
	
	@RequestMapping(value="recommendList", method=RequestMethod.GET)
	public void recommendList(String criteria, String subCriteria, Model model, HttpSession session){
		List<BasicMovieDTO> movieList = new ArrayList<BasicMovieDTO>(); // 영화 리스트
		Map<String, Object> criteria_map = new HashMap<String, Object>(); // 조건 map
		criteria_map.put("kind", "basic");
		Map<String, Object> movie_map = new HashMap<String, Object>(); // 넘겨줄 list map
		try{
			// 장르별
			if(criteria.equals("genre")){
				criteria_map.put("genre", subCriteria);
			}
			// 년도별
			else if(criteria.equals("year")){
				criteria_map.put("year", Integer.parseInt(subCriteria));
			}
			// 감독별 별점 평균 순위
			else if(criteria.equals("director")){
				criteria_map.put("director", "director");
				List<DirectorDTO> directorList = recommendService.directorList();
				movie_map.put("directorList", directorList);
			}
			// 나이별 최다관람순
			else if(criteria.equals("age")){
				List<String> memberList = new ArrayList<String>();
				List<AgeViewDTO> ageViewList = new ArrayList<AgeViewDTO>();
				
				criteria_map.put("age", subCriteria);
				memberList = recommendService.ageGroupList(criteria_map);
				
				if(memberList.size()>0){
					criteria_map.put("ageListCheck", "check");
					criteria_map.put("ageList", memberList);
					ageViewList = recommendService.ageGroupViewList(criteria_map);
				}
				
				if(ageViewList.size()>0){
					movie_map.put("ageViewList", ageViewList);
				}else{
					movie_map.put("noListMessage", "NO LIST");
				}
			}
			// 오늘날씨
			else if(criteria.equals("weather")){
				Getweather getweather = new Getweather();
				String sky_code = getweather.getWeather();
				if(sky_code!=null){
					if(sky_code.equalsIgnoreCase("SKY_D01") ||sky_code.equalsIgnoreCase("SKY_D02")){
						criteria_map.put("weather", 0);
					}else if(sky_code.equalsIgnoreCase("SKY_D03") ||sky_code.equalsIgnoreCase("SKY_D04")){
						criteria_map.put("weather", 1);
					}else{
						criteria_map.put("weather", 2);
					}
				}
			} 
			// 그룹별 
			else if(criteria.equals("group")){
				criteria_map.put("group", subCriteria);
			}
			// 내가 본 영화와 비슷한 영화
			else if(criteria.equals("my")){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("kind", "basic");
				map.put("id", ((MemberDTO)session.getAttribute("memberDTO")).getId());
				try {
					List<BasicMovieDTO> myViewList = viewCheckService.viewCheckList(map);
					for(BasicMovieDTO basicMovieDTO: myViewList){
						System.out.println(basicMovieDTO.getGenre());
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			// 리뷰 순위
			else if(criteria.equals("review")){
				List<ReviewRankDTO> reviewList = recommendService.reviewList(criteria_map);
				movie_map.put("reviewList", reviewList);
			}
			// 찜하기 순위
			else if(criteria.equals("jjim")){
				List<JjimRankDTO> jjimList = recommendService.jjimRankList(criteria_map);
				movie_map.put("jjimList", jjimList);
			}
			// 개봉예정작
			else if(criteria.equals("recent")){
				List<BasicMovieDTO> recentList = recommendService.recentList(criteria_map);
				movie_map.put("recentList", recentList);
			}
			movieList = recommendService.genreList(criteria_map);
			movie_map.put("movieList", movieList);
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("movie_map", movie_map).addAttribute("criteria", criteria);
	}
}
