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
import com.icia.web.model.FineNews;
import com.icia.web.model.FineNewsFile;
import com.icia.web.model.FineUser;
import com.icia.web.model.Paging;
import com.icia.web.model.Response;
import com.icia.web.service.FineNewsService;
import com.icia.web.service.UserService;
import com.icia.web.util.CookieUtil;
import com.icia.web.util.HttpUtil;
import com.icia.web.util.JsonUtil;

@Controller("newsController")

public class NewsController {
	
	private static Logger logger = LoggerFactory.getLogger(ShowController.class);

	//쿠키명
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private FineNewsService fineNewsService;
	
	@Autowired
	private UserService userService;
	
	
	private static final int LIST_COUNT = 10;
	private static final int PAGE_COUNT = 10;
	
	
	//게시물 수정
	@RequestMapping(value="/news/updateProc", method=RequestMethod.POST)
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
			
			FineNews fineNews = fineNewsService.boardSelect(bbsSeq);
			
			if(fineNews != null) {
				
				if(StringUtil.equals(fineNews.getUserId(), cookieUserId)) {
					fineNews.setBbsSeq(bbsSeq);
					fineNews.setBbsTitle(bbsTitle);
					fineNews.setBbsContent(bbsContent);
					
					if(fileData != null && fileData.getFileSize() > 0) {
						
						FineNewsFile fineNewsFile = new FineNewsFile();
						fineNewsFile.setFileName(fileData.getFileName());
						fineNewsFile.setFileOrgName(fileData.getFileOrgName());
						fineNewsFile.setFileExt(fileData.getFileExt());
						fineNewsFile.setFileSize(fileData.getFileSize());
						
						fineNews.setFineNewsFile(fineNewsFile);
					}
					
					try	{
						
						if(fineNewsService.boardUpdate(fineNews) > 0) {
							
							ajaxResponse.setResponse(0, "Success");
							
						}	else {
							
							ajaxResponse.setResponse(500, "Internal Server Error");
							
						}
					}
					catch(Exception e) {
						
						logger.error("[NewsController] /news/updateProc Exception", e);
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
			
			logger.debug("[NewsController] /news/updateProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}
		
		return  ajaxResponse;
	}
	
	//게시물 수정 폼
	@RequestMapping(value="/news/newsUpdate")
	public String updateForm(ModelMap model, HttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String searchType = HttpUtil.get(request, "searchType", "");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		FineNews fineNews = null;
		FineUser fineUser = null;
		
		if(bbsSeq > 0) {
			
			fineNews = fineNewsService.boardView(bbsSeq);
			
			if(fineNews != null) {
				
				if(StringUtil.equals(fineNews.getUserId(), cookieUserId)) {
					
					fineUser = userService.fineUserSelect(cookieUserId);
					
				}	else {
										
					fineNews = null;
					
				}
			}
		}

		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("fineNews", fineNews);
		model.addAttribute("fineUser", fineUser);		
		
		return "/news/newsUpdate";
	}
	
	//게시물 답변
	@RequestMapping(value="/news/replyProc", method=RequestMethod.POST)
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
			
			FineNews parentFineNews = fineNewsService.boardSelect(bbsSeq);
			
			if(parentFineNews != null)	{
				
				FineNews fineNews = new FineNews();
				
				fineNews.setUserId(cookieUserId);
				fineNews.setBbsTitle(bbsTitle);
				fineNews.setBbsContent(bbsContent);
				fineNews.setBbsGroup(parentFineNews.getBbsGroup());
				fineNews.setBbsOrder(parentFineNews.getBbsOrder() + 1);
				fineNews.setBbsIndent(parentFineNews.getBbsIndent() + 1);
				
				if(fileData != null && fileData.getFileSize() > 0) {
					
					FineNewsFile fineNewsFile = new FineNewsFile();
					
					fineNewsFile.setFileName(fileData.getFileName());
					fineNewsFile.setFileOrgName(fileData.getFileOrgName());
					fineNewsFile.setFileExt(fileData.getFileExt());
					fineNewsFile.setFileSize(fileData.getFileSize());
					
					fineNews.setFineNewsFile(fineNewsFile);
					
				}
				
				try	{
					
					if(fineNewsService.boardReplyInsert(fineNews) > 0) {
					
						ajaxResponse.setResponse(0, "Success");
					
					}	else {
						
						ajaxResponse.setResponse(500, "Internal Server Error");
						
					}
				}
				catch(Exception e) {
					
					logger.error("[NewsController] /news/replyProc Exception", e);
					ajaxResponse.setResponse(500, "Internal Server Error");
				
				}
				
			}	else {
				
				ajaxResponse.setResponse(404, "Not Found");
			
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "Bad Request");
		
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[NewsController] /news/replyProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}
		
		return ajaxResponse;
	}
		
	
	//게시물 조회
	@RequestMapping(value="/news/view")
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		String searchType = HttpUtil.get(request, "searchType");
		String searchValue = HttpUtil.get(request, "searchValue", "");
		long curPage = HttpUtil.get(request, "curPage", (long)1);
		
		//본인글 확인 여부
		String boardMe = "N";
		
		FineNews fineNews = null;
		
		if(bbsSeq > 0) {
			
			fineNews = fineNewsService.boardView(bbsSeq);
			
			logger.debug("fineNews.getUserID() : " + fineNews.getUserId());
			logger.debug("cookieUserId : " + cookieUserId);
			
			if(fineNews != null && StringUtil.equals(fineNews.getUserId(), cookieUserId)) {
				
				boardMe = "Y";
				
			}			
		}
		
		model.addAttribute("bbsSeq", bbsSeq);
		model.addAttribute("fineNews", fineNews);
		model.addAttribute("boardMe", boardMe);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);		
		
		return "/news/view";
		
	}
	
	//게시물 쓰기
	@RequestMapping(value="/news/newsWrite")
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
		
		return "/news/newsWrite";
	}
	
	//게시물 삭제
	@RequestMapping(value="/news/delete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> delete(HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long bbsSeq = HttpUtil.get(request, "bbsSeq", (long)0);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(bbsSeq > 0) {
			
			FineNews fineNews = fineNewsService.boardSelect(bbsSeq);
			
			if(fineNews != null) {
				
				if(StringUtil.equals(fineNews.getUserId(), cookieUserId)) {
					
					try	{
						
						if(fineNewsService.boardDelete(fineNews.getBbsSeq()) > 0)	{
							
							ajaxResponse.setResponse(0, "Success");
							
						}	else {
							
							ajaxResponse.setResponse(500, "Internal Server Error");
							
						}
						
					}
					catch(Exception e) {
						
						logger.error("[FineBoardController] /news/delete Exception", e);
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
			
			logger.debug("[FineBoardController] /news/delete response\n" + JsonUtil.toJsonPretty(ajaxResponse));
		
		}
		
		return ajaxResponse;
	}
	
	
	//게시물 등록
	@RequestMapping(value="/news/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response)
	{
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String bbsTitle = HttpUtil.get(request, "bbsTitle", "");
		String bbsContent = HttpUtil.get(request, "bbsContent", "");
		FileData fileData = HttpUtil.getFile(request, "fineNewsFile", UPLOAD_SAVE_DIR);
		
		Response<Object> ajaxResponse = new Response<Object>();
		
		if(!StringUtil.isEmpty(bbsTitle) && !StringUtil.isEmpty(bbsContent)) {
			
			FineNews fineNews = new FineNews();
			
			fineNews.setUserId(cookieUserId);
			fineNews.setBbsTitle(bbsTitle);
			fineNews.setBbsContent(bbsContent);
			
			if(fileData != null && fileData.getFileSize() > 0) {
				
				FineNewsFile fineNewsFile = new FineNewsFile();
				
				fineNewsFile.setFileName(fileData.getFileName());
				fineNewsFile.setFileOrgName(fileData.getFileOrgName());
				fineNewsFile.setFileExt(fileData.getFileExt());
				fineNewsFile.setFileSize(fileData.getFileSize());
				
				fineNews.setFineNewsFile(fineNewsFile);
				
			}
			
			try	{
				
				if(fineNewsService.boardInsert(fineNews) > 0)	{
					
					ajaxResponse.setResponse(0, "Success");
					
				}	else { 
					
					ajaxResponse.setResponse(500, "Internal Server Error");
					
				}
				
			}
			catch(Exception e) {
				
				logger.error("[NewsController]/news/writeProc Exception", e);
				ajaxResponse.setResponse(500, "Internal Server Error");
				
			}
			
		}	else {
			
			ajaxResponse.setResponse(400, "Bad Request");
			
		}
		
		if(logger.isDebugEnabled())	{
			
			logger.debug("[NewsController] /news/writeProc response\n" + JsonUtil.toJsonPretty(ajaxResponse));
			
		}
		
		return ajaxResponse;
	}
	
	
	//게시물 리스트
	@RequestMapping(value="/news/list")
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
		List<FineNews> list = null;
		//페이징 객체
		Paging paging = null;
		//조회객체
		FineNews search = new FineNews();
		//유저객체
		FineUser fineUser = userService.fineUserSelect(cookieUserId);
		
		
		if(!StringUtil.isEmpty(searchType) && !StringUtil.isEmpty(searchValue)) {
			
			search.setSearchType(searchType);
			search.setSearchValue(searchValue);
			
		}	else {
			
			searchType = "";
			searchValue = "";
			
		}
		
		totalCount = fineNewsService.boardListCount(search);
		
		logger.debug("totalCount : " + totalCount);
		logger.debug("curPage : " + curPage);
		
		if(totalCount > 0) {
			
			paging = new Paging("/news/list", totalCount, LIST_COUNT, PAGE_COUNT, curPage, "curPage");
			
			paging.addParam("searchType", searchType);
			paging.addParam("searchValue", searchValue);
			paging.addParam("curPage", curPage);
			
			search.setStartRow(paging.getStartRow());
			search.setEndRow(paging.getEndRow());
			
			list = fineNewsService.boardList(search);			
		}
		
		model.addAttribute("user", fineUser);
		model.addAttribute("list", list);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchValue", searchValue);
		model.addAttribute("curPage", curPage);
		model.addAttribute("paging", paging);
		
		
		return "/news/list";
	}
}
