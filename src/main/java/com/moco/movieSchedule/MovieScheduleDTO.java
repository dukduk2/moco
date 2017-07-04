package com.moco.movieSchedule;

import java.sql.Date;

public class MovieScheduleDTO {

	private int num;
	private String title;
	private Date moviedate;
	private int pnum;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getMoviedate() {
		return moviedate;
	}
	public void setMoviedate(Date moviedate) {
		this.moviedate = moviedate;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
}
