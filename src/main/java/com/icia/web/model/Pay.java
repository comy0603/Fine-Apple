package com.icia.web.model;

import java.io.Serializable;

public class Pay implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	
	private long paySeq;			//결제번호
	private String pgCompany;		//PG사 이름
	private String kind;			//거래구분, 종류
	private String merUid;			//상품고유번호
	private String orderName;		//주문명
	private long payment;			//결제금액
	private String userAddr;		//구매자 주소
	private String userPostcode;	//구매자 우편번호
	private String buyDate;			//구매 일자
	private String status;			//결제 상태
	
	private String userId;			//구매자 아이디
	private String userName;		//구매자명
	private String userEmail;		//구매자 이메일
	private String userPhone;		//구매자 휴대번호

	
	public Pay() {
		
		paySeq = 0;
		pgCompany = "";
		kind = "";
		merUid = "";
		orderName = "";
		payment = 0;
		userAddr = "";
		userPostcode = "";
		buyDate = "";
		status = "";
		userId = "";
		userName = "";
		userEmail = "";
		userPhone = "";	
		
	}


	public long getPaySeq() {
		return paySeq;
	}


	public void setPaySeq(long paySeq) {
		this.paySeq = paySeq;
	}


	public String getPgCompany() {
		return pgCompany;
	}


	public void setPgCompany(String pgCompany) {
		this.pgCompany = pgCompany;
	}


	public String getKind() {
		return kind;
	}


	public void setKind(String kind) {
		this.kind = kind;
	}


	public String getMerUid() {
		return merUid;
	}


	public void setMerUid(String merUid) {
		this.merUid = merUid;
	}


	public String getOrderName() {
		return orderName;
	}


	public void setOrderName(String orderName) {
		this.orderName = orderName;
	}


	public long getPayment() {
		return payment;
	}


	public void setPayment(long payment) {
		this.payment = payment;
	}


	public String getUserAddr() {
		return userAddr;
	}


	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}


	public String getUserPostcode() {
		return userPostcode;
	}


	public void setUserPostcode(String userPostcode) {
		this.userPostcode = userPostcode;
	}


	public String getBuyDate() {
		return buyDate;
	}


	public void setBuyDate(String buyDate) {
		this.buyDate = buyDate;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
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


	public String getUserPhone() {
		return userPhone;
	}


	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	
}
