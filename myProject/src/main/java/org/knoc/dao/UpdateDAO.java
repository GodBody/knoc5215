package org.knoc.dao;

import java.util.List;

import org.knoc.domain.SearchCriteria;
import org.knoc.domain.UpdateVO;

public interface UpdateDAO {

	public void create(UpdateVO vo) throws Exception;
	
	public UpdateVO read(Integer bno)throws Exception;
	
	public List<UpdateVO> list() throws Exception;
	
	public void updateViewCnt(Integer bno) throws Exception;

	public int listSearchCount(SearchCriteria cri);

	public List<UpdateVO> listSearch(SearchCriteria cri);
	
}
