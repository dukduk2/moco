package com.moco.finalProject;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value="/error/**")
public class ErrorController {

	// 500
	@RequestMapping(value="error500", method=RequestMethod.GET)
	public void error500(HttpServletRequest request, Model model) throws Exception{
		model.addAttribute("status", request.getAttribute("javax.servlet.error.status_code"));
		model.addAttribute("exception", request.getAttribute("javax.servlet.error.exception"));
	}
}
