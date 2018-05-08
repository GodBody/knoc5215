package org.knoc.service;

import java.util.List;

import org.knoc.domain.UserVO;

public interface AdminService {
	public List<UserVO> listAccount();

	public int listBoardCount();
	
	public int listUpdateCount();
	
	public int listMessageCount();
}
