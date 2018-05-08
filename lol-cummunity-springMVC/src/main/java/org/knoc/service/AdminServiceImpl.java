package org.knoc.service;

import java.util.List;

import javax.inject.Inject;

import org.knoc.dao.AdminDAO;
import org.knoc.domain.UserVO;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDAO dao;

	@Override
	public List<UserVO> listAccount() {
		// TODO Auto-generated method stub
		return dao.listAccount();
	}

	@Override
	public int listBoardCount() {
		// TODO Auto-generated method stub
		return dao.listBoardCount();
	}

	@Override
	public int listUpdateCount() {
		// TODO Auto-generated method stub
		return dao.listUpdateCount();
	}

	@Override
	public int listMessageCount() {
		// TODO Auto-generated method stub
		return dao.listMessageCount();
	}

}
