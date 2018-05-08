package org.knoc.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.knoc.domain.SearchCriteria;
import org.knoc.domain.UpdateVO;
import org.springframework.stereotype.Repository;

@Repository
public class UpdateDAOImpl implements UpdateDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "org.knoc.mapper.UpdateMapper";

	@Override
	public void create(UpdateVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace+".create", vo);
	}

	@Override
	public List<UpdateVO> list() throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".list");
	}

	@Override
	public void updateViewCnt(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace+".updateViewCnt", bno);
	}

	@Override
	public UpdateVO read(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".read", bno);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".listSearchCount", cri);
	}

	@Override
	public List<UpdateVO> listSearch(SearchCriteria cri) {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".listSearch", cri);
	}

}
