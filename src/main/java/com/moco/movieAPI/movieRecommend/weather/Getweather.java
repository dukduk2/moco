package com.moco.movieAPI.movieRecommend.weather;

import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import com.fasterxml.jackson.databind.ObjectMapper;

public class Getweather {
	public String getWeather(){
		String appKey = "e150b4ff-f369-3355-afb3-55993e6c1637";
		String requestURL = "http://apis.skplanetx.com/weather/summary?lon=127.0373932&stnid=&lat=37.4999072&version=1&appKey="+appKey;
		String sky_name = null;
		String sky_code = null;
		try {
			URL url = new URL(requestURL);
			HashMap<String, Object> map = new ObjectMapper().readValue(url, HashMap.class);
			HashMap<String, Object> weather = (HashMap<String, Object>) map.get("weather");
			ArrayList<HashMap<String, Object>> summary = (ArrayList<HashMap<String, Object>>) weather.get("summary");
			HashMap<String, Object> summary_sub = summary.get(0);
			HashMap<String, Object> today = (HashMap<String, Object>) summary_sub.get("today");
			HashMap<String, Object> sky = (HashMap<String, Object>) today.get("sky");
			sky_name = (String) sky.get("name");
			sky_code = (String) sky.get("code");
			// name : 맑음, 구름조금, 구름많음, 흐림, 비, 눈, 비 또는 눈
			// code : SKY_D01, SKY_D02, SKY_D03, SKY_D04, SKY_D05, SKY_D06, SKY_D07
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sky_code;
	}
}
