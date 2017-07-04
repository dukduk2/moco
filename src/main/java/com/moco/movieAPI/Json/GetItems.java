package com.moco.movieAPI.Json;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class GetItems {
	
	public List<String> getItem(HashMap<String, Object> item, String s){
		List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) item.get(s);
		List<String> ar = new ArrayList<String>();
		
		for(int j=0; j<list.size(); j++){
			ar.add((String) ((HashMap<String, Object>)list.get(j)).get("content"));
		}
		return ar;
	}
}
