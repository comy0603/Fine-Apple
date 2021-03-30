/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.controller
 * 파일명     : UserController.java
 * 작성일     : 2021. 1. 20.
 * 작성자     : daekk
 * </pre>
 */
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

/**
 * <pre>
 * 패키지명   : com.icia.web.controller
 * 파일명     : UserController.java
 * 작성일     : 2021. 1. 20.
 * 작성자     : daekk
 * 설명       : 사용자 컨트롤러
 * </pre>
 */
@Controller("userController")
public class UserController
{
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
	
	/**
	 * <pre>
	 * 메소드명   : login
	 * 작성일     : 2021. 1. 21.
	 * 작성자     : daekk
	 * 설명       : 로그인 
	 * </pre>
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return Response<Object>
	 */
	@RequestMapping(value="/user/myInfo")
	public String myInfo(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		
		List<Pay> list = payService.payList(fineUser.getUserId());
		
		List<Reservation> list2 = reservationService.resList(fineUser.getUserId());
		
		
		model.addAttribute("fineUser", fineUser);
		model.addAttribute("paylist", list);		
		model.addAttribute("reslist", list2);
		
		return "/user/myInfo";
			
	}
	
	@RequestMapping(value="/user/myIot")
	public String myIot(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		FineUser fineUser = userService.fineUserSelect(cookieUserId);

		model.addAttribute("fineUser", fineUser);

		return "/user/myIot";
			
	}
	
	
	@RequestMapping(value="/user/loginPage")
	public String loginPage(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
				
			return "redirect:/";
		}
		else
		{
			return "/user/loginPage";
		}
	}
	
	
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> login(HttpServletRequest request, HttpServletResponse response)
	{
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		Response<Object> ajaxResponse = new Response<Object>();
		
		FineUser fineUser = userService.fineUserSelect(userId);
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd))
		{
			
			if(fineUser != null)
			{
				if(StringUtil.equals(fineUser.getStatus(), "N")) 
				{
					ajaxResponse.setResponse(404, "Not vaild User"); // 탈퇴한 회원
				}
				
				else if(StringUtil.equals(fineUser.getUserPwd(), userPwd))
				{
					CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));
					logger.debug(fineUser.getManager());
					
					if(StringUtil.equals(fineUser.getManager(), "Y")) {
						logger.debug(fineUser.getManager());

						ajaxResponse.setResponse(2, "Success");
						
					}	else {
						logger.debug(fineUser.getManager());

						ajaxResponse.setResponse(0, "Success"); // 로그인 성공
						
					}					

				}
				else
				{
					ajaxResponse.setResponse(-1, "Passwords do not match"); // 비밀번호 불일치
				}
			}
			else
			{
				ajaxResponse.setResponse(404, "Not Found"); // 사용자 정보 없음 (Not Found)
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/login response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	/**
	 * <pre>
	 * 메소드명   : loginOut
	 * 작성일     : 2021. 1. 22.
	 * 작성자     : daekk
	 * 설명       : 로그 아웃
	 * </pre>
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return String
	 */
	@RequestMapping(value="/user/loginOut", method=RequestMethod.GET)
	public String loginOut(HttpServletRequest request, HttpServletResponse response)
	{
		if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null)
		{
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}
		
		return "redirect:/";
	}
	
	/**
	 * <pre>
	 * 메소드명   : idCheck
	 * 작성일     : 2021. 1. 22.
	 * 작성자     : daekk
	 * 설명       : 아이디 중복 체크
	 * </pre>
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return Response<Object>
	 */
	@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response)
	{
		String userId = HttpUtil.get(request, "userId");
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(userId))
		{
			if(userService.fineUserSelect(userId) == null)
			{
				ajaxResponse.setResponse(0, "Success"); // 사용가능 아이디
			}
			else
			{
				ajaxResponse.setResponse(100, "Duplicate ID"); // 중복된 아이디 (Duplicate ID)
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/idCheck response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value="/user/emailCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> emailCheck(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String userEmail = HttpUtil.get(request, "userEmail");
		Response<Object> ajaxResponse = new Response<Object>();
		
		logger.debug(userEmail);
		
		if(!StringUtil.isEmpty(userEmail))
		{
			
			if(userService.fineUserEmailSelect(userEmail) == null)
			{
				ajaxResponse.setResponse(0, "Success"); // 사용가능 이메일
			}
			else
			{
				FineUser fineUser = userService.fineUserEmailSelect(userEmail);
				ajaxResponse.setResponse(100, "Duplicate Email", fineUser.getUserId()); // 중복된 이메일 (Duplicate ID)
				model.addAttribute("fineUser", fineUser);
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/emailCheck response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	


	
	/**
	 * <pre>
	 * 메소드명   : regForm
	 * 작성일     : 2021. 1. 22.
	 * 작성자     : daekk
	 * 설명       : 회원가입 폼
	 * </pre>
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return String
	 */
	@RequestMapping(value="/user/regForm", method=RequestMethod.GET)
	public String regForm(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
				
			return "redirect:/";
		}
		else
		{
			return "/user/regForm";
		}
	}
	
	/**
	 * <pre>
	 * 메소드명   : regProc
	 * 작성일     : 2021. 1. 22.
	 * 작성자     : daekk
	 * 수정일		: 2021. 2. 08.
	 * 수정자		: 임재경
	 * 설명       : 회원 등록 (AJAX)
	 * </pre>
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return Response<Object>
	 */
	@RequestMapping(value="/user/regProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> regProc(HttpServletRequest request, HttpServletResponse response)
	{
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		String userName = HttpUtil.get(request, "userName");
		String userEmail = HttpUtil.get(request, "userEmail");
		String userphone = HttpUtil.get(request, "userphone");
		String postcode = HttpUtil.get(request, "postcode");
		String address = HttpUtil.get(request, "address");
		String detailAddress = HttpUtil.get(request, "detailAddress");
		String extraAddress = HttpUtil.get(request, "extraAddress");
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail))
		{
			if(userService.fineUserSelect(userId) == null)
			{
				FineUser fineUser = new FineUser();
				
				fineUser.setUserId(userId);
				fineUser.setUserPwd(userPwd);
				fineUser.setUserName(userName);
				fineUser.setUserEmail(userEmail);
				fineUser.setUserphone(userphone);
				fineUser.setPostcode(postcode);
				fineUser.setAddress(address);
				fineUser.setDetailAddress(detailAddress);
				fineUser.setExtraAddress(extraAddress);
				fineUser.setStatus("Y");
				fineUser.setManager("N");
				fineUser.setTmpId(0);
				fineUser.setDoorId(0);
				
				if(userService.fineUserInsert(fineUser) > 0)
				{
					ajaxResponse.setResponse(0, "Success"); // 회원가입 성공
				}
				else
				{
					ajaxResponse.setResponse(500, "Internal Server Error"); // 회원가입 실패 (Internal Server Error)
				}
			}
			else
			{
				ajaxResponse.setResponse(100, "Duplicate ID"); // 중복된 아이디 (Duplicate ID)
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/regProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}	

	
	/**
	 * <pre>
	 * 메소드명   : updateForm
	 * 작성일     : 2021. 1. 22.
	 * 작성자     : daekk
	 * 설명       : 회원 정보 수정 폼
	 * </pre>
	 * @param model    ModelMap
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return String
	 */
	@RequestMapping(value="/user/updateForm", method=RequestMethod.GET)
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		
		model.addAttribute("user", fineUser);
		
		return "/user/updateForm";
	}
	
	/**
	 * <pre>
	 * 메소드명   : updateProc
	 * 작성일     : 2021. 1. 22.
	 * 작성자     : daekk
	 * 설명       : 회원 정보 수정 (AJAX)
	 * </pre>
	 * @param request  HttpServletRequest
	 * @param response HttpServletResponse
	 * @return Response<Object>
	 */
	@RequestMapping(value="/user/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userPwd = HttpUtil.get(request, "userPwd");
		String userName = HttpUtil.get(request, "userName");
		String userEmail = HttpUtil.get(request, "userEmail");
		String userphone = HttpUtil.get(request, "userphone");
		String postcode = HttpUtil.get(request, "postcode");
		String address = HttpUtil.get(request, "address");
		String detailAddress = HttpUtil.get(request, "detailAddress");
		String extraAddress = HttpUtil.get(request, "extraAddress");
				
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(cookieUserId))
		{
			FineUser fineUser = userService.fineUserSelect(cookieUserId);
			
			if(fineUser != null)
			{
				if(StringUtil.equals(fineUser.getStatus(), "Y"))
				{
					if(!StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail) && !StringUtil.isEmpty(userphone))
					{
						fineUser.setUserPwd(userPwd);
						fineUser.setUserName(userName);
						fineUser.setUserEmail(userEmail);
						fineUser.setUserphone(userphone);

						
						if(!StringUtil.isEmpty(postcode) && !StringUtil.isEmpty(address) && !StringUtil.isEmpty(detailAddress))
						{
							fineUser.setPostcode(postcode);      
							fineUser.setAddress(address);
							fineUser.setDetailAddress(detailAddress);
							fineUser.setExtraAddress(extraAddress);      
						}
						
						if(userService.fineUserUpdate(fineUser) > 0)
						{
							ajaxResponse.setResponse(0, "success"); // 회원정보 수정 성공
						}
						else
						{
							ajaxResponse.setResponse(500, "Internal Server Error"); // 회원정보 수정 실패 (Internal Server Error)
						}
					}
					else
					{
						// 파라미터가 올바르지 않음
						ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
					}
				}
				else
				{
					// 정지된 사용자 (쿠키 삭제)
					CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
					ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
				}
			}
			else
			{
				// 사용자 정보 없음 (쿠키 삭제)
				CookieUtil.deleteCookie(request, response, AUTH_COOKIE_NAME);
				ajaxResponse.setResponse(404, "Not Found"); // 사용자 정보 없음 (Not Found)
			}
		}
		else
		{
			ajaxResponse.setResponse(400, "Bad Request"); // 파라미터가 올바르지 않음 (Bad Request)
		}
		
		if(logger.isDebugEnabled())
		{
			logger.debug("[UserController] /user/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		}
		
		return ajaxResponse;
	}
	
	@RequestMapping(value = "/model/VerifyRecaptcha", method = RequestMethod.POST)
	@ResponseBody
	public int VerifyRecaptcha(HttpServletRequest request) {
	    VerifyRecaptcha.setSecretKey("6LdCfEsaAAAAAJGcIBuYE_Uez3DPzygTom3LRETJ");
	    String gRecaptchaResponse = request.getParameter("recaptcha");
	    try {
	       if(VerifyRecaptcha.verify(gRecaptchaResponse)) {
	          return 0; // 성공
	       }else {
	    	   return 1; // 실패
	       }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return -1; //에러
	    }
	}	
	
	@RequestMapping(value="/user/userStatusUpdate", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> userStatusUpdate(HttpServletRequest request, HttpServletResponse response) {
		
		String userId = HttpUtil.get(request, "userId");
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(userId)) {
			
			FineUser fineUser = userService.fineUserSelect(userId);
			
			if(StringUtil.equals(fineUser.getStatus(), "Y")) {				

				try	{
					
					if(userService.fineUserStatusUpdate(fineUser) > 0)	{
						
						ajaxResponse.setResponse(0, "Success");	
											
					}	else {
						
						ajaxResponse.setResponse(500, "Internal Server Error");
						
					}
					
				}
				catch(Exception e) {
					
					logger.error("[UserController] /user/userStatusUpdate Exception", e);
					ajaxResponse.setResponse(500, "Internal Server Error");
					
				}		
					
			}	else {
				
				ajaxResponse.setResponse(400, "Not Found1");
				
			}
				
		}	else {
			
			ajaxResponse.setResponse(400, "Not Found2");
			
		}
			
		if(logger.isDebugEnabled())	{
			
			logger.debug("[UserController] /user/userStatusUpdate response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}
		
		return ajaxResponse;
	}
	
	
	

}
