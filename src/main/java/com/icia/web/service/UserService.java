/**
 * <pre>
 * 프로젝트명 : HiBoard
 * 패키지명   : com.icia.web.service
 * 파일명     : UserService.java
 * 작성일     : 2021. 1. 20.
 * 작성자     : daekk
 * </pre>
 */
package com.icia.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.web.dao.FineUserDao;
import com.icia.web.model.FineUser;

/**
 * <pre>
 * 패키지명   : com.icia.web.service
 * 파일명     : UserService.java
 * 작성일     : 2021. 1. 20.
 * 작성자     : daekk
 * 수정일		: 2021. 2. 08
 * 수정자		: 임재경
 * 설명       : 사용자 서비스
 * </pre>
 */
@Service("userService")
public class UserService
{
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	/**
	 * @Autowired : IoC컨테이너 안에 존재하는 Bean을 자동으로 주입한다.
	 */

	@Autowired
	private FineUserDao fineUserDao;
	
	/**
	 * <pre>
	 * 메소드명   : fineUserInsert
	 * 작성일     : 2021. 1. 20.
	 * 작성자     : daekk
	 * 수정일		: 2021. 2. 08.
	 * 수정자		: 임재경
	 * 설명       : 사용자 등록
	 * </pre>
	 * @param Fineuser fineUser
	 * @return int
	 */

	public int fineUserInsert(FineUser fineUser)
	{
		int count = 0;
		
		try
		{
			count = fineUserDao.fineUserInsert(fineUser);
		}
		catch(Exception e)
		{
			logger.error("[UserService] fineUserInsert Exception", e);
		}
		
		return count;
	}
	
	/**
	 * <pre>
	 * 메소드명   : fineUserUpdate
	 * 작성일     : 2021. 2. 08.
	 * 작성자     : jack
	 * 설명       : 사용자 수정
	 * </pre>
	 * @param fineUser fineUser
	 * @return int
	 */

	public int fineUserUpdate(FineUser fineUser)
	{
		int count = 0;
		
		try
		{
			count = fineUserDao.fineUserUpdate(fineUser);
		}
		catch(Exception e)
		{
			logger.error("[UserService] fineUserUpdate Exception", e);
		}
		
		return count;
	}
	
	/**
	 * <pre>
	 * 메소드명   : fineUserStatusUpdate
	 * 작성일     : 2021. 1. 20.
	 * 작성자     : daekk
	 * 수정일		: 2021. 2. 08.
	 * 수정자		: 임재경
	 * 설명       : 사용자 상태 수정
	 * </pre>
	 * @param FineUser fineUser
	 * @return int
	 */
	public int fineUserStatusUpdate(FineUser fineUser)
	{
		int count = 0;
		
		try
		{
			count = fineUserDao.fineUserStatusUpdate(fineUser);
		}
		catch(Exception e)
		{
			logger.error("[UserService] fineUserStatusUpdate Exception", e);
		}
		
		return count;
	}
	
	public int fineUserAdminUpdate(FineUser fineUser)
	{
		int count = 0;
		
		try
		{
			count = fineUserDao.fineUserAdminUpdate(fineUser);
		}
		catch(Exception e)
		{
			logger.error("[UserService] fineUserStatusUpdate Exception", e);
		}
		
		return count;
	}
	
	/**
	 * <pre>
	 * 메소드명   : fineUserSelect
	 * 작성일     : 2021. 1. 20.
	 * 작성자     : daekk
	 * 수정일		: 2021. 2. 08.
	 * 수정자		: 임재경
	 * 설명       : 사용자 조회
	 * </pre>
	 * @param userId 사용자 아이디
	 * @return FineUser
	 */
	public FineUser fineUserSelect(String userId)
	{
		FineUser fineUser = null;
		
		try
		{
			fineUser = fineUserDao.fineUserSelect(userId);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userSelect Exception", e);
		}
		
		return fineUser;
	}
	
	public FineUser fineUserEmailSelect(String userEmail)
	{
		FineUser fineUser = null;
		
		try
		{
			fineUser = fineUserDao.fineUserEmailSelect(userEmail);
		}
		catch(Exception e)
		{
			logger.error("[UserService] fineUserEmailSelect Exception", e);
		}
		
		return fineUser;
	}
	
	
	public List<FineUser> userList(String status)
	{
		List<FineUser> list = null;
		
		try
		{
			list = fineUserDao.userList(status);
		}
		catch(Exception e)
		{
			logger.error("[UserService] userList Exception", e);
		}
		
		return list;
	}
	
	public int fineUserSensorUpdate(FineUser fineUser) {
		
		int count = 0;
		
		try {
			
			count = fineUserDao.fineUserSensorUpdate(fineUser);
		
		}
		catch(Exception e) {
			
			logger.error("[UserService] fineUserSensorUpdate Exception", e);
	
		}
		
		return count;
	}

	
}
