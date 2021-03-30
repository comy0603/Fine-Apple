package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.FineBoard;
import com.icia.web.model.FineBoardFile;

@Repository("fineBoardDao")
public interface FineBoardDao 
{
	//게시물 총수
	public long boardListCount(FineBoard fineBoard);
	
	//게시물 조회
	public List<FineBoard> boardList(FineBoard fineBoard);
	
	//게시물 등록
	public int boardInsert(FineBoard fineBoard);
	
	//게시물 답글 등록
	public int boardReplyInsert(FineBoard fineBoard);
	
	//게시물 조회
	public FineBoard boardSelect(long fineBbsSeq);
	
	//게시물 수정
	public int boardUpdate(FineBoard fineBoard);
	
	//게시물 그룹 순서 변경
	public int boardGroupOrderUpdate(FineBoard fineBoard);
	
	//조회수 증가
	public int boardReadCntPlus(long fineBbsSeq);
	
	//게시물 삭제
	public int boardDelete(long fineBbsSeq);
	
	//게시물 첨부파일 등록
	public int boardFileInsert(FineBoardFile fineBoardFile);
	
	//게시물 첨부파일 조회
	public FineBoardFile boardFileSelect(long fineBbsSeq);
	
	//게시물 첨부파일 삭제
	public int boardFileDelete(long fineBbsSeq);
}
