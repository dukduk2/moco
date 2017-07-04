package com.moco.fileTest;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class FileDownload extends AbstractView{
	
	public FileDownload() {
		setContentType("application/download;charset-UTF-8");
	}
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		File file = (File)model.get("downloadFile");
		
		response.setCharacterEncoding(getContentType());
		response.setContentLength((int)file.length());
		
		String fileName = URLEncoder.encode(file.getName(),"UTF-8");
		response.setHeader("content-Disposition", "attachment;filename-\""+fileName+"\"");
		response.setHeader("Content-Transfer-Encoding", "binary");
		
		OutputStream out = response.getOutputStream();
		FileInputStream in = new FileInputStream(file);
		
		FileCopyUtils.copy(in, out);
		in.close();
		out.close();
		
	}

}