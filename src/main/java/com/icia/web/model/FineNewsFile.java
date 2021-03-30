package com.icia.web.model;

import java.io.Serializable;

public class FineNewsFile implements Serializable
{
	private static final long serialVersionUID = 1L;

	private long bbsSeq;			//게시물 번호
	private short fileSeq;			//파일번호
	private String fileOrgName;		//원본파일명
	private String fileName;		//파일명
	private String fileExt;			//파일 확장자
	private long fileSize;			//파일 크기(byte)
	private String regDate;			//등록일
	
	public FineNewsFile()
	{
		bbsSeq = 0;
		fileSeq = 0;
		fileOrgName = "";
		fileName = "";
		fileExt = "";
		fileSize = 0;
		regDate = "";
	}

	public long getBbsSeq() {
		return bbsSeq;
	}

	public void setBbsSeq(long hiBbsSeq) {
		this.bbsSeq = hiBbsSeq;
	}

	public short getFileSeq() {
		return fileSeq;
	}

	public void setFileSeq(short fileSeq) {
		this.fileSeq = fileSeq;
	}

	public String getFileOrgName() {
		return fileOrgName;
	}

	public void setFileOrgName(String fileOrgName) {
		this.fileOrgName = fileOrgName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}
