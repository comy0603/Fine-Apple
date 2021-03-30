package com.icia.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icia.common.util.StringUtil;
import com.icia.web.model.VerifyRecaptcha;
import com.icia.web.model.FineUser;
import com.icia.web.model.Pay;
import com.icia.web.model.Reservation;
import com.icia.web.model.Response;
import com.icia.web.service.PayService;
import com.icia.web.service.ReservationService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;


@Controller("adminController")
public class AdminController {
	
	private static Logger logger = LoggerFactory.getLogger(UserController.class);

	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PayService payService;
	
	@Autowired
	private ReservationService reservationService;
	
	@RequestMapping(value="/admin/admin")
	public String admin(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/admin/admin";
			
	}
	
	@RequestMapping(value="/admin/userInfo")
	public String userInfo(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		List<FineUser> list = userService.userList("Y");
		
		List<Pay> list2 = payService.payList2("Wait");
		
		List<Reservation> list3 = reservationService.resList2();


		model.addAttribute("userList", list);
		model.addAttribute("payList", list2);	
		model.addAttribute("resList", list3);		

		
		return "/admin/userInfo";
			
	}
	
	@RequestMapping(value="/admin/userIotInfo")
	public String userIotInfo(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);

		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		

		List<FineUser> list = userService.userList("Y");
		
		List<Pay> list2 = payService.payList2("Wait");
		
		List<Reservation> list3 = reservationService.resList2();


		model.addAttribute("userList", list);
		model.addAttribute("payList", list2);	
		model.addAttribute("resList", list3);		

		
		return "/admin/userIotInfo";
			
	}
	
	@RequestMapping(value="/admin/adminUpdate", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> adminUpdate(HttpServletRequest request, HttpServletResponse response) {
		
		String userId = HttpUtil.get(request, "userId");
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(userId)) {
			
			FineUser fineUser = userService.fineUserSelect(userId);
			
			if(StringUtil.equals(fineUser.getManager(), "N")) {
				
				try {
					
					if(userService.fineUserAdminUpdate(fineUser) > 0) {
						
						ajaxResponse.setResponse(0, "Success");
						
					}	else {
						
						ajaxResponse.setResponse(500, "Internal Server Error");
						
					}
					
				}
				catch(Exception e) {
					
					logger.error("[AdminController] /admin/adminUpdate Exception", e);
					ajaxResponse.setResponse(500, "Internal Server Error");
					
				}
				
			}	else {
				
				ajaxResponse.setResponse(400, "Not Found");
				
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "Not Found");
			
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[AdminController] /admin/adminUpdate response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}
		
		return ajaxResponse;
		
	}	
	
	@RequestMapping(value="/admin/userSensorUpdate", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> sensorUpdate(HttpServletRequest request, HttpServletResponse response) {
		
		String userId = HttpUtil.get(request, "userId");
		int doorId = HttpUtil.get(request, "doorId", 0);
		int tmpId = HttpUtil.get(request, "tmpId", 0);
		int widgetDoor = HttpUtil.get(request, "widgetDoor", 0);
		int widgetTmp = HttpUtil.get(request, "widgetTmp", 0);
		
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(userId)) {
			
			FineUser fineUser = userService.fineUserSelect(userId);
			
			if(doorId != 0 || tmpId != 0) {
				
				fineUser.setDoorId(doorId);
				fineUser.setTmpId(tmpId);
				fineUser.setWidgetDoor(widgetDoor);
				fineUser.setWidgetTmp(widgetTmp);
								
				try {
					
					if(userService.fineUserSensorUpdate(fineUser) > 0) {
						
						ajaxResponse.setResponse(0, "Success");
						
					}	else {
						
						ajaxResponse.setResponse(500, "Internal Server Error");
						
					}
					
				}
				catch(Exception e) {
					
					logger.error("[AdminController] /admin/adminUpdate Exception", e);
					ajaxResponse.setResponse(500, "Internal Server Error");
					
				}
				
			}	else {
				
				ajaxResponse.setResponse(400, "Not Found1");
				
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "Not Found2");
			
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[AdminController] /admin/adminUpdate response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}
		
		return ajaxResponse;
		
	}	
	
	
}
