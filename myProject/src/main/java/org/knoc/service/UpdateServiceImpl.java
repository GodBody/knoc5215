package org.knoc.service;

import java.util.List;

import javax.inject.Inject;

import org.knoc.dao.UpdateDAO;
import org.knoc.domain.SearchCriteria;
import org.knoc.domain.UpdateVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UpdateServiceImpl implements UpdateService {
	
	@Inject
	private UpdateDAO dao;

	@Override
	public void regist(UpdateVO vo) throws Exception {
		// TODO Auto-generated method stub
		dao.create(vo);
	}

	@Override
	public List<UpdateVO> list() throws Exception {
		// TODO Auto-generated method stub
		return dao.list();
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public UpdateVO read(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		dao.updateViewCnt(bno);
		return dao.read(bno);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) {
		// TODO Auto-generated method stub
		return dao.listSearchCount(cri);
	}

	@Override
	public List<UpdateVO> listSearchCriteria(SearchCriteria cri) {
		// TODO Auto-generated method stub
		return dao.listSearch(cri);
	}

}
