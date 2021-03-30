package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.FineNews;
import com.icia.web.model.FineNewsFile;

@Repository("fineNewsDao")
public interface FineNewsDao 
{
	//게시물 총수
	public long boardListCount(FineNews fineNews);
	
	//게시물 조회
	public List<FineNews> boardList(FineNews fineNews);
	
	//게시물 등록
	public int boardInsert(FineNews fineNews);
	
	//게시물 답글 등록
	public int boardReplyInsert(FineNews fineNews);
	
	//게시물 조회
	public FineNews boardSelect(long bbsSeq);
	
	//게시물 수정
	public int boardUpdate(FineNews fineNews);
	
	//게시물 그룹 순서 변경
	public int boardGroupOrderUpdate(FineNews fineNews);
	
	//조회수 증가
	public int boardReadCntPlus(long bbsSeq);
	
	//게시물 삭제
	public int boardDelete(long bbsSeq);
	
	//게시물 첨부파일 등록
	public int boardFileInsert(FineNewsFile fineNewsFile);
	
	//게시물 첨부파일 조회
	public FineNewsFile boardFileSelect(long bbsSeq);
	
	//게시물 첨부파일 삭제
	public int boardFileDelete(long fineBbsSeq);
}
