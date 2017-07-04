package com.moco.fileTest;

import java.io.File;
import java.util.Calendar;
import java.util.UUID;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class FileSaver {

	public void fileDelete(String path, String fileName) throws Exception{
		File f = new File(path); // 경로명
		if(!f.exists()){
			f.mkdirs();
		}
		File file = new File(f, fileName); // 파일name 
		file.delete();
	}
	
	public String saver2(MultipartFile multipartFile, String path) throws Exception{
		String fileName = multipartFile.getOriginalFilename();
		fileName = this.getSaveName2(fileName);
		
		File f = new File(path); // 경로명
		if(!f.exists()){
			f.mkdirs();
		}

		File file = new File(f, fileName);
		
		// 저장코드
		// source , destination
		FileCopyUtils.copy(multipartFile.getBytes(), file);
		
		return fileName;
	}
	
	public String saver(MultipartFile multipartFile, String path) throws Exception{
		String fileName = multipartFile.getOriginalFilename();
		fileName = this.getSaveName(fileName);
		
		File f = new File(path); // 경로명
		if(!f.exists()){
			f.mkdirs();
		}
		File file = new File(f, fileName); // 파일name  
		// 저장 코드
		multipartFile.transferTo(file);
		
		return fileName;
	}

	// 1. UUID
	private String getSaveName(String fileName){
		UUID uuid = UUID.randomUUID();
		return uuid.toString()+"_"+fileName;
	}
	
	// 2. Time 
	private String getSaveName2(String fileName){
		Calendar ca = Calendar.getInstance();
		long l = ca.getTimeInMillis();
		return l+"_"+fileName;
	}
	
}
