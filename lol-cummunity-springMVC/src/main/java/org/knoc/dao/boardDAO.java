package org.knoc.dao;

import java.util.List;

import org.knoc.domain.Board;
import org.knoc.domain.Criteria;
import org.knoc.domain.Reply;
import org.knoc.domain.SearchCriteria;

public interface boardDAO {
	public void create(Board board) throws Exception;

	public Board read(Integer bno) throws Exception;

	public void update(Board board) throws Exception;

	public void delete(Integer bno) throws Exception;

	public List<Board> listAll() throws Exception;

	public List<Board> listPage(int page) throws Exception;

	public List<Board> listCriteria(Criteria cri) throws Exception;

	public int countPaging(Criteria cri) throws Exception;

	public List<Board> listSearch(SearchCriteria cri) throws Exception;

	public int listSearchCount(SearchCriteria cri) throws Exception;

	public void updateReplyCnt(Integer bno, int amount) throws Exception;
	
	public void updateViewCnt(Integer bno)throws Exception;
	
	public void addAttach(String fullName) throws Exception;
	
	public List<String> getAttach(Integer bno)throws Exception;
	
	public void deleteAttach(Integer bno)throws Exception;
	
	public void replaceAttach(String fullName, Integer bno)throws Exception;

	public List<Reply> listReply(int bno);
}
