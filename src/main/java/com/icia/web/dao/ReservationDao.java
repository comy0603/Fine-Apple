package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.Reservation;

@Repository("reservationDao")
public interface ReservationDao 
{
	//예약추가
	public int resInsert(Reservation reservation);
	
	public Reservation resSelect(String resDate);
	
	public List<Reservation> resList(String userId);
	
	public List<Reservation> resList2();	
	
	public int resCancel(long resSeq);
	
}