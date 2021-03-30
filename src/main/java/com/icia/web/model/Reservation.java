
package com.icia.web.model;

import java.io.Serializable;

public class Reservation implements Serializable 
{
	private static final long serialVersionUID = 1L;
	
	private long resSeq;			//예약번호
	private String userId;			//예약자
	private String resDate;			//예약날짜/시간
	private long resTitle;			//고장분류(1:기기문제 2:서비스문제 3:기타)
	private long resModel;			//모델
	private String resContent;		//고장 상세내용
	private String userPhone;		//예약자 연락처
	private String buyerPcode;		//예약자 우편번호
	private String buyerAddr;		//예약자 주소
	private String buyerDeAddr;		//예약자 상세주소
	private String buyerExAddr;		//예약자 주소 참고항목
	
	private String userName;		//사용자 이름
	private String userEmail;		//사용자 이메일
	
	public Reservation()
	{
		resSeq = 0;
		userId = "";
		resDate = "";
		resTitle = 0;
		resModel = 0;
		resContent = "";
		userPhone = "";
		buyerPcode = "";
		buyerAddr = "";
		buyerDeAddr = "";
		buyerExAddr = "";
		
		userName = "";
		userEmail = "";
	}

	public long getResSeq() {
		return resSeq;
	}

	public void setResSeq(long resSeq) {
		this.resSeq = resSeq;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getResDate() {
		return resDate;
	}

	public void setResDate(String resDate) {
		this.resDate = resDate;
	}

	public long getResTitle() {
		return resTitle;
	}

	public void setResTitle(long resTitle) {
		this.resTitle = resTitle;
	}
	
	public long getResModel() {
		return resModel;
	}

	public void setResModel(long resModel) {
		this.resModel = resModel;
	}

	public String getResContent() {
		return resContent;
	}

	public void setResContent(String resContent) {
		this.resContent = resContent;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getBuyerPcode() {
		return buyerPcode;
	}

	public void setBuyerPcode(String buyerPcode) {
		this.buyerPcode = buyerPcode;
	}

	public String getBuyerAddr() {
		return buyerAddr;
	}

	public void setBuyerAddr(String buyerAddr) {
		this.buyerAddr = buyerAddr;
	}

	public String getBuyerDeAddr() {
		return buyerDeAddr;
	}

	public void setBuyerDeAddr(String buyerDeAddr) {
		this.buyerDeAddr = buyerDeAddr;
	}

	public String getBuyerExAddr() {
		return buyerExAddr;
	}

	public void setBuyerExAddr(String buyerExAddr) {
		this.buyerExAddr = buyerExAddr;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
}
