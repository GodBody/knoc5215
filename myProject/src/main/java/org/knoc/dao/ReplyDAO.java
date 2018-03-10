package org.knoc.dao;

import java.util.List;

import org.knoc.domain.Criteria;
import org.knoc.domain.Reply;

public interface ReplyDAO {
	public List<Reply> list(Integer bno) throws Exception;

	public void create(Reply reply) throws Exception;

	public void update(Reply reply) throws Exception;

	public void delete(Integer rno) throws Exception;
	
	public List<Reply> listPage(Integer bno, Criteria cri) throws Exception;
	
	public int count(Integer bno) throws Exception;
	
	public int getBno(Integer rno)throws Exception;
}
