package com.icia.web.dao;


import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Pay;

@Repository("payDao")
public interface PayDao  {
	
	//구매 정보 추가
	public int payInsert(Pay pay);

	//구매 정보 조회
	public Pay paySelect(String merUid);
	
	//구매 정보 수정(구매 취소시)
	public int payUpdate(Pay pay);
	
	//구매 정보 전체조회
	public List<Pay> payList(String userId);
	
	//결제 취소 전체 조회
	public List<Pay> payList2(String status);
	
	//구매 정보 총 개수
	public long payListCount(String userId);

}
