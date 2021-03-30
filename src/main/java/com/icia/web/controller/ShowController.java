package com.icia.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;




@Controller("showController")
public class ShowController {
	


	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	
	@RequestMapping(value="/show/aboutUs")
	public String aboutUs(HttpServletRequest request, HttpServletResponse response)
	{

		return "/show/aboutUs";

	}
	
	@RequestMapping(value="/show/price")
	public String price(HttpServletRequest request, HttpServletResponse response)
	{

		return "/show/price";

	}
	
	@RequestMapping(value="/show/product")
	public String product(HttpServletRequest request, HttpServletResponse response)
	{

		return "/show/product";

	}
	
	@RequestMapping(value="/show/fAq")
	public String fAq(HttpServletRequest request, HttpServletResponse response)
	{

		return "/show/fAq";

	}

	
}
