package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.icia.common.util.FileUtil;
import com.icia.web.dao.FineNewsDao;
import com.icia.web.model.FineNews;
import com.icia.web.model.FineNewsFile;


@Service("fineNewsService")
public class FineNewsService {
	
	private static Logger logger = LoggerFactory.getLogger(FineNewsService.class);
	
	//파일 저장 디렉토리
	@Value("{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private FineNewsDao fineNewsDao;
	
	//게시물 삭제(파일이 있는경우 같이 삭제)
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardDelete(long bbsSeq) throws Exception
	{
		int count = 0;
		
		FineNews fineNews = boardView(bbsSeq);
		
		if(fineNews != null)
		{
			count = fineNewsDao.boardDelete(bbsSeq);
			
			if(count > 0)
			{
				FineNewsFile fineNewsFile = fineNews.getFineNewsFile();
				
				if(fineNewsFile != null)
				{
					if(fineNewsDao.boardFileDelete(bbsSeq) > 0)
					{
						logger.debug("==========delete file : " + UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + fineNewsFile.getFileName());
						FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + fineNewsFile.getFileName());
					}
				}
			}
		}
		
		return count;
	}
	
	
	//총 게시물 수
	public long boardListCount(FineNews fineNews)
	{
		long count = 0;
		
		try
		{
			count = fineNewsDao.boardListCount(fineNews);
		}
		catch(Exception e)
		{
			logger.error("[FineNewsService] boardListCount Exception", e);
		}
		
		return count;
	}
	
	//게시물 리스트
	public List<FineNews> boardList(FineNews fineNews)
	{
		List<FineNews> list = null;
		
		try
		{
			list = fineNewsDao.boardList(fineNews);
		}
		catch(Exception e)
		{
			logger.error("[FineNewsService] boardList Exception", e);
		}
		
		return  list;
	}
	
	//게시물 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardInsert(FineNews fineNews) throws Exception {
		int count = fineNewsDao.boardInsert(fineNews);
		
		//게시물 등록이 되었으면, 첨부파일이 있다면 첨부파일 등록
		if(count > 0 && fineNews.getFineNewsFile() != null) {
			FineNewsFile fineNewsFile = fineNews.getFineNewsFile();
			
			fineNewsFile.setBbsSeq(fineNews.getBbsSeq());
			fineNewsFile.setFileSeq((short)1);
			
			fineNewsDao.boardFileInsert(fineNewsFile);
		}
		
		return count;
	}
	
	//게시물 조회
	public FineNews boardSelect(long bbsSeq)
	{
		FineNews fineNews = null;
		
		try
		{
			fineNews = fineNewsDao.boardSelect(bbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[FineNewsService] boardSelect Exception", e);
		}
		
		return fineNews;
	}
	
	//게시물 보기
	public FineNews boardView(long bbsSeq) {
		
		FineNews fineNews = null;
		
		try {
			
			fineNews = fineNewsDao.boardSelect(bbsSeq);
			
			if(fineNews != null) {
				
				//조회수 증가
				fineNewsDao.boardReadCntPlus(bbsSeq);
				
				FineNewsFile fineNewsFile = fineNewsDao.boardFileSelect(bbsSeq);
				
				if(fineNewsFile != null) {
					
					fineNews.setFineNewsFile(fineNewsFile);
					
				}					
			}
		}
		catch(Exception e) {
			
			logger.error("[FineNewsService] boardView Exception", e);
			
		}
		
		return fineNews;
		
	}
	
	//댓글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardReplyInsert(FineNews fineNews) throws Exception
	{
		fineNewsDao.boardGroupOrderUpdate(fineNews);
		
		int count = fineNewsDao.boardReplyInsert(fineNews);
		
		if(count > 0 && fineNews.getFineNewsFile() != null)
		{
			FineNewsFile fineNewsFile = fineNews.getFineNewsFile();
			
			fineNewsFile.setBbsSeq(fineNews.getBbsSeq());
			fineNewsFile.setFileSeq((short)1);
			
			fineNewsDao.boardFileInsert(fineNewsFile);
		}
		
		return count;
	}
	
	//게시물 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardUpdate(FineNews fineNews) throws Exception
	{
		int count = fineNewsDao.boardUpdate(fineNews);
		
		if(count > 0 && fineNews.getFineNewsFile() != null)
		{
			FineNewsFile delFineNewsFile = fineNewsDao.boardFileSelect(fineNews.getBbsSeq());
			
			//기존 파일이 있으면 삭제
			if(delFineNewsFile != null)
			{
				logger.debug("delete file info : " + UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delFineNewsFile.getFileName());
				FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delFineNewsFile.getFileName());
				
				fineNewsDao.boardFileDelete(fineNews.getBbsSeq());
			}
			
			FineNewsFile fineNewsFile = fineNews.getFineNewsFile();
			
			fineNewsFile.setBbsSeq(fineNews.getBbsSeq());
			fineNewsFile.setFileSeq((short)1);
			
			fineNewsDao.boardFileInsert(fineNews.getFineNewsFile());
		}
		
		return count;
	}
	

}
