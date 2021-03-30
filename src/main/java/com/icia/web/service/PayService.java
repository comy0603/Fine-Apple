package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.PayDao;
import com.icia.web.model.Pay;

@Service("payService")
public class PayService {
	
	private static Logger logger = LoggerFactory.getLogger(PayService.class);
	
	@Autowired
	private PayDao payDao;
	
	
	//구매 정보 추가
	public int payInsert(Pay pay) {
		
		int count = 0;
		
		try {
		
			count = payDao.payInsert(pay);
			
		}
		catch(Exception e) {
			
			logger.error("[PayService] payInsert Exception", e);
		
		}
		
		return count;
	}

	//구매 정보 조회
	public Pay paySelect(String merUid) {
		
		Pay pay = null;
		
		try {
			
			pay = payDao.paySelect(merUid);
			
		}
		catch(Exception e) {
			
			logger.error("[PayService] paySelect Exception", e);
			
		}
		
		return pay;
		
	}
	
	//구매 정보 수정(구매 취소시)
	public int payUpdate(Pay pay) {
		
		int count = 0;
		
		try {
			
			count = payDao.payUpdate(pay);
			
		}
		catch(Exception e) {
			
			logger.error("[PayService] payUpdate Exception", e);
			
		}
		
		return count;
	
	};

	//구매 정보 전체조회
	public List<Pay> payList(String userId) {
		
		List<Pay> list = null;
		
		try
		{
			list = payDao.payList(userId);
		}
		catch(Exception e)
		{
			logger.error("[PayService] payList Exception", e);
		}
		
		return  list;
		
		
	}
	
	public List<Pay> payList2(String status) {
		
		List<Pay> list = null;
		
		try
		{
			list = payDao.payList2(status);
		}
		catch(Exception e)
		{
			logger.error("[PayService] payList2 Exception", e);
		}
		
		return  list;
		
		
	}
		
	//구매 정보 총 개수
	public long payListCount(String userId) {
		
		long count = 0;
		
		try
		{
			count = payDao.payListCount(userId);
		}
		catch(Exception e)
		{
			logger.error("[PayService] payListCount Exception", e);
		}
		
		return count;
	}

}
