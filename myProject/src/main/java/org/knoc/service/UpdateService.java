package org.knoc.service;

import java.util.List;

import org.knoc.domain.SearchCriteria;
import org.knoc.domain.UpdateVO;

public interface UpdateService {
	public void regist(UpdateVO vo) throws Exception;
	
	public UpdateVO read(Integer bno) throws Exception;

	public List<UpdateVO> list() throws Exception;

	public int listSearchCount(SearchCriteria cri);

	public List<UpdateVO> listSearchCriteria(SearchCriteria cri);
}
