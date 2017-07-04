package com.moco.movieAPI.movieRecommend.subDTO;

import com.moco.movieAPI.BasicMovieDTO;

public class AgeViewDTO extends BasicMovieDTO{
	private int count;
	private int bNum;

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getbNum() {
		return bNum;
	}

	public void setbNum(int bNum) {
		this.bNum = bNum;
	}
}
