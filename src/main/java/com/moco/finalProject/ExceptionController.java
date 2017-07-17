package com.moco.finalProject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.NestedServletException;

@ControllerAdvice
public class ExceptionController{
	
	private static final Logger logger = LoggerFactory.getLogger(ExceptionController.class);
	
	// Exception
	// numberFormat, nullpoint, nestedServlet, IllegalState 등등
	@ExceptionHandler(Exception.class)
	public ModelAndView exceptionProcess(Exception exception){
		logger.info(exception.getMessage());
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("error/error");
		// numberFormatException
		if(exception instanceof NumberFormatException){
			modelAndView.addObject("message", "NumberFormatException");
		}else if(exception instanceof NullPointerException){
			modelAndView.addObject("message", "NullPointerException");
		}else if(exception instanceof NestedServletException){
			modelAndView.addObject("message", "NestedServletException");
		}else if(exception instanceof IllegalStateException){
			modelAndView.addObject("message", "IllegalStateException");
		}else{
			modelAndView.addObject("message", "Exception");
		}
			
		return modelAndView;
	}

	
}
