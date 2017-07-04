package com.moco.movieAPI.movieRecommend.subDTO;

import com.moco.movieAPI.BasicMovieDTO;

public class ReviewRankDTO extends BasicMovieDTO{
	private int count;

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
}
