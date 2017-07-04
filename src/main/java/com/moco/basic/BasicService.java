package com.moco.basic;

public interface BasicService {

	// insert
	public abstract int insert(BasicDTO basicDTO) throws Exception;
	// delete
	public abstract int delete(String id) throws Exception;
	
}
