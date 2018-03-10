package org.knoc.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.knoc.domain.UserVO;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAOImpl implements AdminDAO {

	private static String namespace = "org.knoc.mapper.AdminMapper";
	@Inject
	private SqlSession session;

	@Override
	public List<UserVO> listAccount() {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".listAccount");
	}

	@Override
	public int listBoardCount() {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".listBoardCount");
	}

	@Override
	public int listUpdateCount() {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".listUpdateCount");
	}

	@Override
	public int listMessageCount() {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".listMessageCount");
	}

}
