package com.moco.movieAPI.movieSearch;

public class SearchDTO {
	private String title;
	private String genre;
	private int yearMin;
	private int yearMax;
	private String director;
	private String actor;
	private String nation;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public int getYearMin() {
		return yearMin;
	}
	public void setYearMin(int yearMin) {
		this.yearMin = yearMin;
	}
	public int getYearMax() {
		return yearMax;
	}
	public void setYearMax(int yearMax) {
		this.yearMax = yearMax;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
}
