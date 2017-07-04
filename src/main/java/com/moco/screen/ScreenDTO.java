package com.moco.screen;

import java.sql.Date;

public class ScreenDTO {

	private int num;
	private int multi_num;
	private int movie_num;
	private Date show_date;
	private int hour;
	private int minute;
	private int available_seat;
	private int commit;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getMulti_num() {
		return multi_num;
	}
	public void setMulti_num(int multi_num) {
		this.multi_num = multi_num;
	}
	public int getMovie_num() {
		return movie_num;
	}
	public void setMovie_num(int movie_num) {
		this.movie_num = movie_num;
	}
	public Date getShow_date() {
		return show_date;
	}
	public void setShow_date(Date show_date) {
		this.show_date = show_date;
	}
	public int getHour() {
		return hour;
	}
	public void setHour(int hour) {
		this.hour = hour;
	}
	public int getMinute() {
		return minute;
	}
	public void setMinute(int minute) {
		this.minute = minute;
	}
	public int getAvailable_seat() {
		return available_seat;
	}
	public void setAvailable_seat(int available_seat) {
		this.available_seat = available_seat;
	}
	public int getCommit() {
		return commit;
	}
	public void setCommit(int commit) {
		this.commit = commit;
	}	
	
}
