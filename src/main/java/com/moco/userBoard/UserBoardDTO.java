package com.moco.userBoard;

import com.moco.board.BoardDTO;

public class UserBoardDTO extends BoardDTO {
	
	private String genre;
	private int likes;
	private String season;
	private int videoState;
	private int commit;
	
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public String getSeason() {
		return season;
	}
	public void setSeason(String season) {
		this.season = season;
	}
	public int getVideoState() {
		return videoState;
	}
	public void setVideoState(int videoState) {
		this.videoState = videoState;
	}
	public int getCommit() {
		return commit;
	}
	public void setCommit(int commit) {
		this.commit = commit;
	}
	
}
