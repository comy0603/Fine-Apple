
package com.icia.web.controller;

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
import com.icia.web.model.FineUser;
import com.icia.web.model.Reservation;
import com.icia.web.model.Response;
import com.icia.web.service.ReservationService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("reservationController")
public class ReservationController {
	
	private static Logger logger = LoggerFactory.getLogger(ReservationController.class);

	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	private UserService userService;
	

	@RequestMapping(value="/reservation/reservation")
	public String reservation(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		
		model.addAttribute("fineUser", fineUser);
		
		return "/reservation/reservation";
	}
	
	@RequestMapping(value="/reservation/complete")
	public String resComplete(HttpServletRequest request, HttpServletResponse response)
	{
		
		return "/reservation/complete";
	}
	
	

	@RequestMapping(value="/reservation/resInsertProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> resInsertProc(HttpServletRequest request, HttpServletResponse response)
	{
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String resDate = HttpUtil.get(request, "resDate");
		String userPhone = HttpUtil.get(request, "userPhone", "");
		String buyerPcode = HttpUtil.get(request, "postcode");
		String buyerAddr = HttpUtil.get(request, "roadAddress");
		String buyerDeAddr = HttpUtil.get(request, "detailAddress");
		String buyerExAddr = HttpUtil.get(request, "extraAddress");
		long resModel = HttpUtil.get(request, "modelkind", 0);
		long resTitle = HttpUtil.get(request, "resTitle", 0);
		String resContent = HttpUtil.get(request, "resContent");
		
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPhone) && !StringUtil.isEmpty(buyerPcode) && !StringUtil.isEmpty(resContent)) {
			
			Reservation reservation = new Reservation();
			
			reservation.setUserId(userId);
			reservation.setUserPhone(userPhone);
			reservation.setResDate(resDate);
			reservation.setBuyerPcode(buyerPcode);
			reservation.setBuyerAddr(buyerAddr);
			reservation.setBuyerDeAddr(buyerDeAddr);
			reservation.setBuyerExAddr(buyerExAddr);
			reservation.setResContent(resContent);
			reservation.setResTitle(resTitle);
			reservation.setResModel(resModel);
				
			try	{
				
				if(reservationService.resInsert(reservation) > 0)	{
					
					ajaxResponse.setResponse(0, "Success");
					
				}	else { 
					
					ajaxResponse.setResponse(500, "Internal Server Error");
					
				}
				
			}
			catch(Exception e) {
				
				logger.error("[ReservationController] /reservation/resInsertProc Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
				
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "Bad Request");
			
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[ReservationController] /reservation/resInsertProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			
		}
		
		return ajaxResponse;
	}
	
	
	@RequestMapping(value="/reservation/resSelect", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> resSelect(HttpServletRequest request, HttpServletResponse response) {
		
		String resDate = HttpUtil.get(request, "resDate");
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(resDate)) {
			
			Reservation reservation = reservationService.resSelect(resDate);
			
			try {
				
				if(reservation.getResDate() == null) {
					
					ajaxResponse.setResponse(500, "Success");

				}	else {
					
					ajaxResponse.setResponse(0, "Already exist_1");

				}
			}
			catch(Exception e) {
				
				logger.error("[ReservationController] /reservation/resSelect Exception", e);
				ajaxResponse.setResponse(500, "Already exist_2");
				
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "No resDate");
			
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[ReservationController] /reservation/resSelect response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			
		}
		
		return ajaxResponse;

	}
	
	
	@RequestMapping(value="/reservation/resCancel", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> resCancel(HttpServletRequest request, HttpServletResponse response) {
		
		long resSeq = HttpUtil.get(request, "resSeq", (long)0);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(resSeq > 0) {
			
			
			try {
				
				if(reservationService.resCancel(resSeq) > 0) {
					
					ajaxResponse.setResponse(0, "Success");
					
				}	else {
					
					ajaxResponse.setResponse(500, "Internal Server Error");
				}
			}
			catch(Exception e) {
				
				logger.error("[ReservationController] /reservation/resCancel Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
				
			}

		}	else {
			
			ajaxResponse.setResponse(400, "Bad Request");
			
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[ReservationController] /reservation/resCancel response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			
		}
		
		return ajaxResponse;
	}

}
