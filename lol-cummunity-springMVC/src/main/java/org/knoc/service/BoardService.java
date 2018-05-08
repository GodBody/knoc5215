package org.knoc.service;

import java.util.List;

import org.knoc.domain.Board;
import org.knoc.domain.Criteria;
import org.knoc.domain.Reply;
import org.knoc.domain.SearchCriteria;

public interface BoardService {
	public void regist(Board board) throws Exception;

	public Board read(Integer bno) throws Exception;

	public void modify(Board board) throws Exception;

	public void remove(Integer bno) throws Exception;

	public List<Board> listAll() throws Exception;

	public List<Board> listCriteria(Criteria cri) throws Exception;

	public int listCountCriteria(Criteria cri) throws Exception;

	public List<Board> listSearchCriteria(SearchCriteria cri) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public List<String> getAttach(Integer bno)throws Exception;

	public List<Reply> listReply(int bno);
	
}
