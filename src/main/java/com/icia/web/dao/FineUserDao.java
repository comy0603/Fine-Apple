package com.icia.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.icia.web.model.FineUser;

@Repository("fineUserDao")
public interface FineUserDao {
	
	public int fineUserInsert(FineUser fineUser);
	
	public int fineUserUpdate(FineUser fineUser);
	
	public int fineUserStatusUpdate(FineUser fineUser);
	
	public int fineUserAdminUpdate(FineUser fineUser);
	
	public FineUser fineUserSelect(String userId);
	
	public FineUser fineUserEmailSelect(String userEmail);
	
	public List<FineUser> userList(String status);

	public int fineUserSensorUpdate(FineUser fineUser);
}
