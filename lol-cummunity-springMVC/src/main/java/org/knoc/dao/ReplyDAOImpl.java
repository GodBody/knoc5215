package org.knoc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.knoc.domain.Criteria;
import org.knoc.domain.Reply;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "org.knoc.mapper.ReplyMapper";

	@Override
	public List<Reply> list(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace + ".list", bno);
	}

	@Override
	public void create(Reply reply) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".create", reply);
	}

	@Override
	public void update(Reply reply) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".update", reply);
	}

	@Override
	public void delete(Integer rno) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace + ".delete", rno);
	}

	@Override
	public List<Reply> listPage(Integer bno, Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("bno", bno);
		paramMap.put("cri", cri);

		return session.selectList(namespace + ".listPage", paramMap);
	}

	@Override
	public int count(Integer bno) throws Exception {

		return session.selectOne(namespace + ".count", bno);

	}

	@Override
	public int getBno(Integer rno) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".getBno", rno);
	}

}
