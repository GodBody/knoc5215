package org.knoc.service;

import java.util.List;

import javax.inject.Inject;

import org.knoc.dao.boardDAO;
import org.knoc.domain.Board;
import org.knoc.domain.Criteria;
import org.knoc.domain.Reply;
import org.knoc.domain.SearchCriteria;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private boardDAO dao;

	@Transactional
	@Override
	public void regist(Board board) throws Exception {
		// TODO Auto-generated method stub
		dao.create(board);

		String[] files = board.getFiles();

		if (files == null) {
			return;
		}

		for (String fileName : files) {
			dao.addAttach(fileName);
		}
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public Board read(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		dao.updateViewCnt(bno);
		return dao.read(bno);
	}

	@Transactional
	@Override
	public void modify(Board board) throws Exception {
		// TODO Auto-generated method stub
		dao.update(board);

		Integer bno = board.getBno();

		dao.deleteAttach(bno);

		String[] files = board.getFiles();

		if (files == null) {
			return;
		}

		for (String fileName : files) {
			dao.replaceAttach(fileName, bno);
		}

	}

	@Transactional
	@Override
	public void remove(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		dao.deleteAttach(bno);
		dao.delete(bno);
	}

	@Override
	public List<Board> listAll() throws Exception {
		// TODO Auto-generated method stub
		return dao.listAll();
	}

	@Override
	public List<Board> listCriteria(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.countPaging(cri);
	}

	@Override
	public List<Board> listSearchCriteria(SearchCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.listSearchCount(cri);
	}

	@Override
	public List<String> getAttach(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.getAttach(bno);
	}

	@Override
	public List<Reply> listReply(int bno) {
		// TODO Auto-generated method stub
		return dao.listReply(bno);
	}

}
