package org.knoc.dao;

import java.util.List;

import org.knoc.domain.UserVO;

public interface AdminDAO {
	public List<UserVO> listAccount();

	public int listBoardCount();
	public int listUpdateCount();
	public int listMessageCount();
}
