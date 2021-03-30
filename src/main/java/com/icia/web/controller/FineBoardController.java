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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.common.model.FileData;
import com.icia.common.util.StringUtil;
import com.icia.web.model.FineBoard;
import com.icia.web.model.FineBoardFile;
import com.icia.web.model.FineUser;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.service.FineBoardService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("fineBoardController")
public class FineBoardController {
	
	private static Logger logger = LoggerFactory.getLogger(FineBoardController.class);
	
	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private FineBoardService fineBoardService;
	
	@Autowired
	private UserService userService;
	
	private static final int LIST_COUNT = 10;
	private static final int PAGE_COUNT = 10;
	
	//게시물 수정
	@RequestMapping(value="/board/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "bbsFile", UPLOAD_SAVE_DIR);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent)) {
			
			FineBoard fineBoard = fineBoardService.boardSelect(bbsSeq);
			
			if(fineBoard != null) {
				
				if(StringUtil.equals(fineBoard.getUserId(), cookieUserId)) {
					fineBoard.setBbsSeq(bbsSeq);
					fineBoard.setBbsTitle(bbsTitle);
					fineBoard.setBbsContent(bbsContent);
					
					if(fileData != null && fileData.getFileSize() > 0) {
						
						FineBoardFile fineBoardFile = new FineBoardFile();
						fineBoardFile.setFileName(fileData.getFileName());
						fineBoardFile.setFileOrgName(fileData.getFileOrgName());
						fineBoardFile.setFileExt(fileData.getFileExt());
						fineBoardFile.setFileSize(fileData.getFileSize());
						
						fineBoard.setFineBoardFile(fineBoardFile);
					}
					
					try	{
						
						if(fineBoardService.boardUpdate(fineBoard) > 0) {
							
							ajaxResponse.setResponse(0, "Success");
							
						}	else {
							
							ajaxResponse.setResponse(500, "Internal Server Error");
							
						}
					}
					catch(Exception e) {
						
						logger.error("[FineBoardController] /board/updateProc Exception", e);
						ajaxResponse.setResponse(500, "Internal Server Error");
						
					}
					
				}	else {
					
					ajaxResponse.setResponse(404, "Not Found");
					
				}
				
			}	else { 
				
				ajaxResponse.setResponse(404, "Not Found");
				
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "Bad Request");
			
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[FineBoardController] /board/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}
		
		return  ajaxResponse;
	}
	
	//게시물 수정 폼
	@RequestMapping(value="/board/updateForm")
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		FineBoard fineBoard = null;
		FineUser fineUser = null;
		
		if(bbsSeq > 0) {
			
			fineBoard = fineBoardService.boardView(bbsSeq);
			
			if(fineBoard != null) {
				
				if(StringUtil.equals(fineBoard.getUserId(), cookieUserId)) {
					
					fineUser = userService.fineUserSelect(cookieUserId);
					
				}	else {
										
					fineBoard = null;
					
				}
			}
		}

		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("fineBoard", fineBoard);
		model.addAttribute("fineUser", fineUser);		
		
		return "/board/updateForm";
	}
	
	//게시물 답변
	@RequestMapping(value="/board/replyProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		
		FileData fileData = HttpUtil.getFile(request, "fineBbsFile", UPLOAD_SAVE_DIR);
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(bbsSeq > 0 && !StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent)) {
			
			FineBoard parentFineBoard = fineBoardService.boardSelect(bbsSeq);
			
			if(parentFineBoard != null)	{
				
				FineBoard fineBoard = new FineBoard();
				
				fineBoard.setUserId(cookieUserId);
				fineBoard.setBbsTitle(bbsTitle);				
				fineBoard.setBbsContent(bbsContent);
				fineBoard.setPassword(parentFineBoard.getPassword());
				fineBoard.setBbsGroup(parentFineBoard.getBbsGroup());
				fineBoard.setBbsOrder(parentFineBoard.getBbsOrder() + 1);
				fineBoard.setBbsIndent(parentFineBoard.getBbsIndent() + 1);
				
				if(fileData != null && fileData.getFileSize() > 0) {
					
					FineBoardFile fineBoardFile = new FineBoardFile();
					
					fineBoardFile.setFileName(fileData.getFileName());
					fineBoardFile.setFileOrgName(fileData.getFileOrgName());
					fineBoardFile.setFileExt(fileData.getFileExt());
					fineBoardFile.setFileSize(fileData.getFileSize());
					
					fineBoard.setFineBoardFile(fineBoardFile);
					
				}
				
				try	{
					
					if(fineBoardService.boardReplyInsert(fineBoard) > 0) {
					
						ajaxResponse.setResponse(0, "Success");
					
					}	else {
						
						ajaxResponse.setResponse(500, "Internal Server Error");
						
					}
				}
				catch(Exception e) {
					
					logger.error("[FineBoardController] /board/replyProc Exception", e);
					ajaxResponse.setResponse(500, "Internal Server Error");
				
				}
				
			}	else {
				
				ajaxResponse.setResponse(404, "Not Found");
			
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "Bad Request");
		
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[FineBoardController] /board/replyProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}
		
		return ajaxResponse;
	}
		
	//게시물 답변 폼
	@RequestMapping(value="/board/replyForm", method=RequestMethod.POST)
	public String replyForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		
		String searchType = HttpUtil.get(request, "searchType");
		String searchValue = HttpUtil.get(request, "searchValue");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		FineBoard fineBoard = null;
		FineUser fineUser = null;
		
		if(bbsSeq > 0)
		{
			fineBoard = fineBoardService.boardSelect(bbsSeq);
			
			if(fineBoard != null)
			{
				fineUser = userService.fineUserSelect(cookieUserId);
			}
			
		}
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("fineBoard", fineBoard);
		model.addAttribute("fineUser", fineUser);
		
		return "/board/replyForm";
	}
	
	
	//게시물 삭제
	@RequestMapping(value="/board/delete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> delete(HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long fineBbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(fineBbsSeq > 0) {
			
			FineBoard fineBoard = fineBoardService.boardSelect(fineBbsSeq);
			
			if(fineBoard != null) {
				
				if(StringUtil.equals(fineBoard.getUserId(), cookieUserId)) {
					
					try	{
						
						if(fineBoardService.boardDelete(fineBoard.getBbsSeq()) > 0)	{
							
							ajaxResponse.setResponse(0, "Success");
							
						}	else {
							
							ajaxResponse.setResponse(500, "Internal Server Error");
							
						}
						
					}
					catch(Exception e) {
						
						logger.error("[FineBoardController] /board/delete Exception", e);
						ajaxResponse.setResponse(500, "Internal Server Error");
						
					}		
					
				}	else {
					
					ajaxResponse.setResponse(400, "Not Found");
					
				}
				
			}	else {
				
				ajaxResponse.setResponse(400, "Not Found");
				
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "Bad Request");
			
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[FineBoardController] /board/delete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}
		
		return ajaxResponse;
	}
	
	//게시물 조회
	@RequestMapping(value="/board/view")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String searchType = HttpUtil.get(request, "searchType");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		//본인글 확인 여부
		String boardMe = "N";
		
		FineBoard fineBoard = null;
		
		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		
		if(bbsSeq > 0) {
			
			fineBoard = fineBoardService.boardView(bbsSeq);
			
			logger.debug("fineBoard.getUserID() : " + fineBoard.getUserId());
			logger.debug("cookieUserId : " + cookieUserId);
			
			if(fineBoard != null && StringUtil.equals(fineBoard.getUserId(), cookieUserId)) {
				
				boardMe = "Y";
				
			}			
		}
		
		model.addAttribute("fineUser", fineUser);
		model.addAttribute("bbsSeq", bbsSeq);
		model.addAttribute("fineBoard", fineBoard);
		model.addAttribute("boardMe", boardMe);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);		
		
		return "/board/view";
		
	}
	
	//게시물 쓰기
	@RequestMapping(value="/board/writeForm")
	public String writeForm(ModelMap model, HttpServletRequest request, HttpServletResponse response) 
	{
		//쿠키값
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String searchType = HttpUtil.get(request, "searchType");
		String searchValue = HttpUtil.get(request, "searchValue");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		//사용자 정보 조회
		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("fineUser", fineUser);
		
		return "/board/writeForm";
	}
	
	//게시물 등록
	@RequestMapping(value="/board/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String password = HttpUtil.get(request, "password");
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "fineBbsFile", UPLOAD_SAVE_DIR);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent)) {
			
			FineBoard fineBoard = new FineBoard();
			
			fineBoard.setUserId(cookieUserId);
			fineBoard.setPassword(password);
			fineBoard.setBbsTitle(bbsTitle);
			fineBoard.setBbsContent(bbsContent);
			
			if(fileData != null && fileData.getFileSize() > 0) {
				
				FineBoardFile fineBoardFile = new FineBoardFile();
				
				fineBoardFile.setFileName(fileData.getFileName());
				fineBoardFile.setFileOrgName(fileData.getFileOrgName());
				fineBoardFile.setFileExt(fileData.getFileExt());
				fineBoardFile.setFileSize(fileData.getFileSize());
				
				fineBoard.setFineBoardFile(fineBoardFile);
				
			}
			
			try	{
				
				if(fineBoardService.boardInsert(fineBoard) > 0)	{
					
					ajaxResponse.setResponse(0, "Success");
					
				}	else { 
					
					ajaxResponse.setResponse(500, "Internal Server Error");
					
				}
				
			}
			catch(Exception e) {
				
				logger.error("[FineBoardController]/board/writeProc Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
				
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "Bad Request");
			
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[FineBoardController] /board/writeProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			
		}
		
		return ajaxResponse;
	}
	
	
	//게시물 리스트
	@RequestMapping(value="/board/list")
	public String list(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		//조회항목(1:작성자조회, 2:제목조회, 3:내용조회)
		String searchType = HttpUtil.get(request, "searchType");
		//조회값
		String searchValue = HttpUtil.get(request, "searchValue");
		//현재 페이지
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		//조회값
		long totalCount = 0;
		
		//게시물 리스트
		List<FineBoard> list = null;
		//페이징 객체
		Paging paging = null;
		//조회객체
		FineBoard search = new FineBoard();
		
		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
			
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
			
		}	else {
			
			searchType = "";
			searchValue = "";
			
		}
		
		totalCount = fineBoardService.boardListCount(search);
		
		logger.debug("totalCount : " + totalCount);
		logger.debug("curPage : " + curPage);
		
		if(totalCount > 0) {
			
			paging = new Paging("/board/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = fineBoardService.boardList(search);			
		}
		
		model.addAttribute("fineUser", fineUser);
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		
		return "/board/list";
	}
}
