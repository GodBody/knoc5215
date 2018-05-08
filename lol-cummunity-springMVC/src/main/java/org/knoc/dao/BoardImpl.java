package org.knoc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.knoc.domain.Board;
import org.knoc.domain.Criteria;
import org.knoc.domain.Reply;
import org.knoc.domain.SearchCriteria;
import org.springframework.stereotype.Repository;

@Repository
public class BoardImpl implements boardDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "org.knoc.mapper.BoardMapper";

	@Override
	public void create(Board board) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".create", board);
	}

	@Override
	public Board read(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".read", bno);
	}

	@Override
	public void update(Board board) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".update", board);
	}

	@Override
	public void delete(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".delete", bno);
	}

	@Override
	public List<Board> listAll() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".listAll");
	}

	@Override
	public List<Board> listPage(int page) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".listPage", page);
	}

	@Override
	public List<Board> listCriteria(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".listCriteria", cri);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".countPaging", cri);
	}

	@Override
	public List<Board> listSearch(SearchCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".listSearch", cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".listSearchCount", cri);
	}

	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("bno", bno);
		paramMap.put("amount", amount);
		session.update(namespace + ".updateReplyCnt", paramMap);
	}

	@Override
	public void updateViewCnt(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".updateViewCnt", bno);
	}

	@Override
	public void addAttach(String fullName) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".addAttach", fullName);
	}

	@Override
	public List<String> getAttach(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".getAttach", bno);
	}

	@Override
	public void deleteAttach(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".deleteAttach", bno);
	}

	@Override
	public void replaceAttach(String fullName, Integer bno) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("fullName", fullName);
		paramMap.put("bno", bno);
		session.insert(namespace + ".replaceAttach", paramMap);
	}

	@Override
	public List<Reply> listReply(int bno) {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".listReply", bno);
	}

}
