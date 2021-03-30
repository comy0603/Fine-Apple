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
import com.icia.web.model.Pay;
import com.icia.web.model.Response;
import com.icia.web.service.PayService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;


@Controller("payController")
public class PayController {
	


	private static Logger logger = LoggerFactory.getLogger(IndexController.class);

	// 쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private PayService payService;
	
	@RequestMapping(value="/pay/payWait", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> payWait(HttpServletRequest request, HttpServletResponse response)
	{
		long paySeq = HttpUtil.get(request, "paySeq", (long)0);
				
		Response<Object> ajaxResponse = new Response<Object>();
		
		
		if(paySeq > 0) {
			
			Pay pay = new Pay();
			
			pay.setPaySeq(paySeq);
			pay.setStatus("Wait");
			
			if(payService.payUpdate(pay) > 0) {
				
				ajaxResponse.setResponse(0, "Success"); // 취소 요청 성공
				
			}	else {
				
				ajaxResponse.setResponse(500, "Internal Server Error"); // 취소 요청 실패 (Internal Server Error)
				
			}
		}	else {
			
			ajaxResponse.setResponse(100, "Not correct parameter"); // 취소 요청 정보가 옳지 않음
		
		}
		
		if(logger.isDebugEnabled()) {
			
			logger.debug("[PayController] /pay/payWait response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}

		return ajaxResponse;
	}
	
	@RequestMapping(value="/pay/payCancel", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> payCancel(HttpServletRequest request, HttpServletResponse response)
	{
		long paySeq = HttpUtil.get(request, "paySeq", (long)0);
				
		Response<Object> ajaxResponse = new Response<Object>();
		
		
		if(paySeq > 0) {
			
			Pay pay = new Pay();
			
			pay.setPaySeq(paySeq);
			pay.setStatus("Cancel");
			
			if(payService.payUpdate(pay) > 0) {
				
				ajaxResponse.setResponse(0, "Success"); // 취소 요청 성공
				
			}	else {
				
				ajaxResponse.setResponse(500, "Internal Server Error"); // 취소 요청 실패 (Internal Server Error)
				
			}
		}	else {
			
			ajaxResponse.setResponse(100, "Not correct parameter"); // 취소 요청 정보가 옳지 않음
		
		}
		
		if(logger.isDebugEnabled()) {
			
			logger.debug("[PayController] /pay/payWait response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}

		return ajaxResponse;
	}
	

	@RequestMapping(value="/pay/payProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> payProc(HttpServletRequest request, HttpServletResponse response)
	{
		String pgCompany = HttpUtil.get(request, "pgCompany");
		String kind = HttpUtil.get(request, "kind");
		String merUid = HttpUtil.get(request, "merUid");
		String orderName = HttpUtil.get(request, "orderName");
		long payment = HttpUtil.get(request, "payment", (long)0);
		String userEmail = HttpUtil.get(request, "userEmail");
		String userName = HttpUtil.get(request, "userName");
		String userPhone = HttpUtil.get(request, "userPhone");
		String userAddr = HttpUtil.get(request, "userAddr");
		String userPostcode = HttpUtil.get(request, "userPostcode");
		String status = HttpUtil.get(request, "status");		
		String userId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
				
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(orderName) && payment != 0)
		{
			Pay pay = new Pay();
				
			pay.setUserId(userId);
			pay.setPgCompany(pgCompany);
			pay.setKind(kind);
			pay.setMerUid(merUid);
			pay.setOrderName(orderName);
			pay.setPayment(payment);
			pay.setUserEmail(userEmail);
			pay.setUserName(userName);
			pay.setUserPhone(userPhone);
			pay.setUserAddr(userAddr);
			pay.setUserPostcode(userPostcode);
			pay.setStatus(status);
				
			if(payService.payInsert(pay) > 0)
			{
				ajaxResponse.setResponse(0, "Success"); // 결제 성공
			}
			else
			{
				ajaxResponse.setResponse(500, "Internal Server Error"); // 결제 실패 (Internal Server Error)
			}
		}
		else
		{
			ajaxResponse.setResponse(100, "Not correct parameter"); // 결제 정보가 옳지 않음
		}

		
		if(logger.isDebugEnabled())
		{
			logger.debug("[PayController] /pay/payProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}	
	
	
	
	
	
	
	@RequestMapping(value="/pay/complete")
	public String complete(ModelMap model,HttpServletRequest request, HttpServletResponse response)
	{
		String merUid = HttpUtil.get(request, "merUid");
		
		logger.debug(merUid);
		Pay pay = null;
		
		if(!StringUtil.isEmpty(merUid)) {
			
			pay = payService.paySelect(merUid);
			
		}
		
		model.addAttribute(pay);
		
		return "/pay/complete";

	}
	
	@RequestMapping(value="/pay/doorPayPage")
	public String payPage(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		
		model.addAttribute("fineUser", fineUser);
		
		return "/pay/doorPayPage";
	}
	
	
	@RequestMapping(value="/pay/firePayPage")
	public String payPage2(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		
		model.addAttribute("fineUser", fineUser);
		
		return "/pay/firePayPage";
	}
	
}
