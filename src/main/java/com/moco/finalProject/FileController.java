package com.moco.finalProject;

import org.springframework.web.bind.annotation.RequestMapping;

import com.moco.util.PhotoDTO;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;

@Controller
@RequestMapping(value="/file/**")
public class FileController {

	@RequestMapping(value="se2")
	public String upload(PhotoDTO photoDTO, HttpSession session){
		String callback=photoDTO.getCallback();
		String callback_func=photoDTO.getCallback_func();
		String file_result="";
		try{
			if(photoDTO.getFiledata()!=null && photoDTO.getFiledata().getOriginalFilename()!=null && !photoDTO.getFiledata().getOriginalFilename().equals("")){
				String original_name=photoDTO.getFiledata().getOriginalFilename();
				String ext=original_name.substring(original_name.lastIndexOf(".")+1);
				//파일 기본경로
				String defaultPath=session.getServletContext().getRealPath("/");
				
				String path=defaultPath+"resources"+File.separator+"upload"+File.separator;
				
				File file=new File(path);
				System.out.println("path:"+path);
				if(!file.exists()){
					file.mkdirs();
				}
				String realname=UUID.randomUUID().toString()+"."+ext;
				
				 photoDTO.getFiledata().transferTo(new File(path,realname));
		            file_result += "&bNewLine=true&sFileName="+original_name+"&sFileURL=/finalProject/resources/upload/"+realname;
		        } else {
		            file_result += "&errstr=error";
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    System.out.println("redirect:" + callback + "?callback_func="+callback_func+file_result);
		    return "redirect:" + callback + "?callback_func="+callback_func+file_result;

	}
}
