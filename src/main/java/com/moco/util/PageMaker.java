package com.moco.util;

public class PageMaker {

	private int curPage;
	private int perPage;
	private PageResult pageResult;
	private RowMaker rowMaker;
	
	public PageMaker(int curPage) {
		this(curPage,10);
	}
	
	public PageMaker(int curPage, int perPage){
		this.curPage=curPage;
		this.perPage=perPage;
		pageResult=new PageResult();
		rowMaker=new RowMaker();
	}
	
	public RowMaker getRowMaker(){
		rowMaker.makeRow(curPage, perPage);
		return rowMaker;
	}
	
	public PageResult paging(int totalCount){
		int totalPage=0;
		
		if(totalCount%perPage==0){
			totalPage=totalCount/perPage;
		}else{
			totalPage=totalCount/perPage+1;
		}
		
		int perBlock=5;
		
		if(totalPage%perBlock==0){
			pageResult.setTotalBlock(totalPage/perBlock);
		}else{
			pageResult.setTotalBlock(totalPage/perBlock+1);
		}
		
		if(curPage%perBlock==0){
			pageResult.setCurBlock(curPage/perBlock);
		}else{
			pageResult.setCurBlock(curPage/perBlock+1);
		}
		
		pageResult.setStartNum((pageResult.getCurBlock()-1)*perBlock+1);
		pageResult.setLastNum(pageResult.getCurBlock()*perBlock);
		
		if(pageResult.getCurBlock()==pageResult.getTotalBlock()){
			pageResult.setLastNum(totalPage);
		}
		
		if(pageResult.getTotalBlock()==0){
			pageResult.setStartNum(1);
			pageResult.setLastNum(1);
		}
		
		return pageResult;
	}
}
