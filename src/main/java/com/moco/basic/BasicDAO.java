package com.moco.basic;

public interface BasicDAO {

	// insert
	public abstract int insert(BasicDTO basicDTO) throws Exception;
	// delete
	public abstract int delete(String id) throws Exception;
	
}
