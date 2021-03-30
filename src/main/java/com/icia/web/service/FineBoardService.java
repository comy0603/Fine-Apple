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
import com.icia.web.dao.FineBoardDao;
import com.icia.web.model.FineBoard;
import com.icia.web.model.FineBoardFile;


@Service("fineBoardService")
public class FineBoardService {
	
	private static Logger logger = LoggerFactory.getLogger(FineBoardService.class);
	
	//파일 저장 디렉토리
	@Value("{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private FineBoardDao fineBoardDao;
	
	//게시물 삭제(파일이 있는경우 같이 삭제)
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardDelete(long bbsSeq) throws Exception
	{
		int count = 0;
		
		FineBoard fineBoard = boardView(bbsSeq);
		
		if(fineBoard != null)
		{
			count = fineBoardDao.boardDelete(bbsSeq);
			
			if(count > 0)
			{
				FineBoardFile fineBoardFile = fineBoard.getFineBoardFile();
				
				if(fineBoardFile != null)
				{
					if(fineBoardDao.boardFileDelete(bbsSeq) > 0)
					{
						logger.debug("==========delete file : " + UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + fineBoardFile.getFileName());
						FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + fineBoardFile.getFileName());
					}
				}
			}
		}
		
		return count;
	}
	
	
	//총 게시물 수
	public long boardListCount(FineBoard fineBoard)
	{
		long count = 0;
		
		try
		{
			count = fineBoardDao.boardListCount(fineBoard);
		}
		catch(Exception e)
		{
			logger.error("[FineBoardService] boardListCount Exception", e);
		}
		
		return count;
	}
	
	//게시물 리스트
	public List<FineBoard> boardList(FineBoard fineBoard)
	{
		List<FineBoard> list = null;
		
		try
		{
			list = fineBoardDao.boardList(fineBoard);
		}
		catch(Exception e)
		{
			logger.error("[FineBoardService] boardList Exception", e);
		}
		
		return  list;
	}
	
	//게시물 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardInsert(FineBoard fineBoard) throws Exception {
		int count = fineBoardDao.boardInsert(fineBoard);
		
		//게시물 등록이 되었으면, 첨부파일이 있다면 첨부파일 등록
		if(count > 0 && fineBoard.getFineBoardFile() != null) {
			FineBoardFile fineBoardFile = fineBoard.getFineBoardFile();
			
			fineBoardFile.setBbsSeq(fineBoard.getBbsSeq());
			fineBoardFile.setFileSeq((short)1);
			
			fineBoardDao.boardFileInsert(fineBoardFile);
		}
		
		return count;
	}
	
	//게시물 조회
	public FineBoard boardSelect(long fineBbsSeq)
	{
		FineBoard fineBoard = null;
		
		try
		{
			fineBoard = fineBoardDao.boardSelect(fineBbsSeq);
		}
		catch(Exception e)
		{
			logger.error("[HiBoardService] boardSelect Exception", e);
		}
		
		return fineBoard;
	}
	
	//게시물 보기
	public FineBoard boardView(long bbsSeq) {
		
		FineBoard fineBoard = null;
		
		try {
			
			fineBoard = fineBoardDao.boardSelect(bbsSeq);
			
			if(fineBoard != null) {
				
				//조회수 증가
				fineBoardDao.boardReadCntPlus(bbsSeq);
				
				FineBoardFile fineBoardFile = fineBoardDao.boardFileSelect(bbsSeq);
				
				if(fineBoardFile != null) {
					
					fineBoard.setFineBoardFile(fineBoardFile);
					
				}					
			}
		}
		catch(Exception e) {
			
			logger.error("[FineBoardService] boardView Exception", e);
			
		}
		
		return fineBoard;
		
	}
	
	//댓글 등록
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardReplyInsert(FineBoard fineBoard) throws Exception
	{
		fineBoardDao.boardGroupOrderUpdate(fineBoard);
		
		int count = fineBoardDao.boardReplyInsert(fineBoard);
		
		if(count > 0 && fineBoard.getFineBoardFile() != null)
		{
			FineBoardFile fineBoardFile = fineBoard.getFineBoardFile();
			
			fineBoardFile.setBbsSeq(fineBoard.getBbsSeq());
			fineBoardFile.setFileSeq((short)1);
			
			fineBoardDao.boardFileInsert(fineBoardFile);
		}
		
		return count;
	}
	
	//게시물 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardUpdate(FineBoard fineBoard) throws Exception
	{
		int count = fineBoardDao.boardUpdate(fineBoard);
		
		if(count > 0 && fineBoard.getFineBoardFile() != null)
		{
			FineBoardFile delFineBoardFile = fineBoardDao.boardFileSelect(fineBoard.getBbsSeq());
			
			//기존 파일이 있으면 삭제
			if(delFineBoardFile != null)
			{
				logger.debug("delete file info : " + UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delFineBoardFile.getFileName());
				FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delFineBoardFile.getFileName());
				
				fineBoardDao.boardFileDelete(fineBoard.getBbsSeq());
			}
			
			FineBoardFile fineBoardFile = fineBoard.getFineBoardFile();
			
			fineBoardFile.setBbsSeq(fineBoard.getBbsSeq());
			fineBoardFile.setFileSeq((short)1);
			
			fineBoardDao.boardFileInsert(fineBoard.getFineBoardFile());
		}
		
		return count;
	}
	

}
