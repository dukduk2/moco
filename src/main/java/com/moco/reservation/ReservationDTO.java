package com.moco.reservation;

public class ReservationDTO {
	private int num;
	private String id;
	private int screen_num;
	private int seat;
	private int rprice;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getScreen_num() {
		return screen_num;
	}
	public void setScreen_num(int screen_num) {
		this.screen_num = screen_num;
	}
	public int getSeat() {
		return seat;
	}
	public void setSeat(int seat) {
		this.seat = seat;
	}
	public int getRprice() {
		return rprice;
	}
	public void setRprice(int rprice) {
		this.rprice = rprice;
	}
	
}
