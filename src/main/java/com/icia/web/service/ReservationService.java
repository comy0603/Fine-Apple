

package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.ReservationDao;
import com.icia.web.model.Reservation;

@Service("reservationService")
public class ReservationService 
{
	private static Logger logger = LoggerFactory.getLogger(ReservationService.class);
	
	@Autowired
	private ReservationDao reservationDao;
	
	public int resInsert(Reservation reservation)
	{
		int count = 0;
		
		try
		{
			count = reservationDao.resInsert(reservation);
		}
		catch(Exception e)
		{
			logger.error("[ReservationService] resInsert Exception", e);
		}
		return count;
	}
	
	public Reservation resSelect(String resDate) throws NullPointerException {
		
		Reservation reservation = null;
		
		reservation = reservationDao.resSelect(resDate);

		return reservation;
	}
	
	public List<Reservation> resList(String userId) {
		
		List<Reservation> list = null;
		
		try
		{
			list = reservationDao.resList(userId);
		}
		catch(Exception e)
		{
			logger.error("[ReservationService] resList Exception", e);
		}
		
		return list;
	}
	
	public List<Reservation> resList2() {
		
		List<Reservation> list = null;
		
		try
		{
			list = reservationDao.resList2();
		}
		catch(Exception e)
		{
			logger.error("[ReservationService] resList Exception", e);
		}
		
		return list;
	}
	
	public int resCancel(long resSeq) {
		
		int count = 0;
		
		try {
			
			count = reservationDao.resCancel(resSeq);
			
		}
		catch(Exception e) {
			
			logger.error("[ReservationService] resCancel Exception", e);
			
		}
		
		return count;
	}
}