package com.moco.finalProject;

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
				int genreList[] = new int[15];
				String genre[] = new String[15];
				ArrayList<Integer> viewNum = new ArrayList<Integer>();
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("kind", "basic");
				map.put("id", ((MemberDTO)session.getAttribute("memberDTO")).getId());

				List<BasicMovieDTO> myViewList = viewCheckService.viewCheckList(map);
				// no List Message
				if(myViewList.size()==0){
					model.addAttribute("noListMessage", "추천 리스트가 없습니다. 더 많은 영화에 '봤어요'를 눌러주세요!");
				}else{
					for(BasicMovieDTO dto : myViewList){
						viewNum.add(dto.getNum());
					}
				}
				for(BasicMovieDTO basicMovieDTO: myViewList){
					String[] sub = (basicMovieDTO.getGenre()).split(",");
					for(int i=0; i<sub.length; i++){
						if(sub[i].equalsIgnoreCase("판타지")){
							genre[0] = "판타지";
							genreList[0]++;
						}else if(sub[i].equalsIgnoreCase("공포")){
							genre[1] = "공포";
							genreList[1]++;
						}else if(sub[i].equalsIgnoreCase("로맨스/멜로")){
							genre[2] = "로맨스/멜로";
							genreList[2]++;
						}else if(sub[i].equalsIgnoreCase("어드벤처")){
							genre[3] = "어드벤처";
							genreList[3]++;
						}else if(sub[i].equalsIgnoreCase("스릴러")){
							genre[4] = "스릴러";
							genreList[4]++;
						}else if(sub[i].equalsIgnoreCase("다큐멘터리")){
							genre[5] = "다큐멘터리";
							genreList[5]++;
						}else if(sub[i].equalsIgnoreCase("코미디")){
							genre[6] = "코미디";
							genreList[6]++;
						}else if(sub[i].equalsIgnoreCase("가족")){
							genre[7] = "가족";
							genreList[7]++;
						}else if(sub[i].equalsIgnoreCase("미스터리")){
							genre[8] = "미스터리";
							genreList[8]++;
						}else if(sub[i].equalsIgnoreCase("전쟁")){
							genre[9] = "전쟁";
							genreList[9]++;
						}else if(sub[i].equalsIgnoreCase("애니메이션")){
							genre[10] = "애니메이션";
							genreList[10]++;
						}else if(sub[i].equalsIgnoreCase("범죄")){
							genre[11] = "범죄";
							genreList[11]++;
						}else if(sub[i].equalsIgnoreCase("뮤지컬")){
							genre[12] = "뮤지컬";
							genreList[12]++;
						}else if(sub[i].equalsIgnoreCase("SF")){
							genre[13] = "SF";
							genreList[13]++;
						}else if(sub[i].equalsIgnoreCase("액션")){
							genre[14] = "액션";
							genreList[14]++;
						}else{

						}
					}
				}
				for(int i=0; i<genre.length; i++){
					for(int j=0; j<genre.length; j++){
						int temp_value = 0;
						String temp_genre = "";
						if(genreList[i]<genreList[j]){
							temp_value = genreList[i];
							temp_genre = genre[i];
							
							genreList[i] = genreList[j];
							genre[i] = genre[j];
							
							genreList[j] = temp_value;
							genre[j] = temp_genre;
						}
					}
				}
				int count = 0;
				ArrayList<String> favorite = new ArrayList<String>();
				for(int i=0; i<genre.length; i++){
					if(genre[i] != null && count <3){
						count++;
						favorite.add(genre[i]);
					}
				}
				criteria_map.put("kind", "basic");
				criteria_map.put("favorite", favorite);
				criteria_map.put("viewNum", viewNum);
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
