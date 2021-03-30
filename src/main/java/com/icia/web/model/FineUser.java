package com.icia.web.model;

import java.io.Serializable;

public class FineUser implements Serializable {

	private static final long serialVersionUID = 1L;
		
	private String userId;    	// 사용자 아이디
	private String userPwd;   	// 비밀번호
	private String userName;  	// 사용자 명
	private String userEmail; 	// 사용자 이메일 
	private String userphone;	// 사용자 연락처

	private String status;    	// 상태 ("Y":사용, "N":정지)
	private String regDate;  	// 등록일
	
	private String manager;		// 관리자 권한
	private int tmpId;			// 온도센서 iot id
	private int doorId;			// 문열림센서 iot id
	private int widgetDoor;			// 센서 widget door id
	private int widgetTmp;			// 센서 widget id

	
	private String postcode;    	// 우편번호
	private String address;    		// 주소
	private String detailAddress;   // 상세주소
	private String extraAddress;    // 참고항목
		
	public FineUser() {
		
		userId = "";
		userPwd = "";
		userName = "";
		userEmail = "";
		userphone = "";

		status = "";
		regDate = "";
		
		manager = "";
		tmpId = 0;
		doorId = 0;
		widgetDoor = 0;
		widgetTmp = 0;
		
		postcode = "";
		address = "";
		detailAddress = "";
		extraAddress = "";
		
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getUserphone() {
		return userphone;
	}

	public void setUserphone(String userphone) {
		this.userphone = userphone;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}

	public String getExtraAddress() {
		return extraAddress;
	}

	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public int getTmpId() {
		return tmpId;
	}

	public void setTmpId(int tmpId) {
		this.tmpId = tmpId;
	}

	public int getDoorId() {
		return doorId;
	}

	public void setDoorId(int doorId) {
		this.doorId = doorId;
	}

	public int getWidgetDoor() {
		return widgetDoor;
	}

	public void setWidgetDoor(int widgetDoor) {
		this.widgetDoor = widgetDoor;
	}

	public int getWidgetTmp() {
		return widgetTmp;
	}

	public void setWidgetTmp(int widgetTmp) {
		this.widgetTmp = widgetTmp;
	}
	
	
}
