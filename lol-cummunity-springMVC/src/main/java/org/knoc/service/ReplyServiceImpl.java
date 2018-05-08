package org.knoc.service;

import java.util.List;

import javax.inject.Inject;

import org.knoc.dao.ReplyDAO;
import org.knoc.dao.boardDAO;
import org.knoc.domain.Criteria;
import org.knoc.domain.Reply;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Inject
	private ReplyDAO replyDAO;

	@Inject
	private boardDAO boardDAO;

	@Transactional
	@Override
	public void addReply(Reply reply) throws Exception {
		// TODO Auto-generated method stub
		replyDAO.create(reply);
		boardDAO.updateReplyCnt(reply.getBno(), 1);
	}

	@Override
	public List<Reply> listReply(Integer bno) throws Exception {
		// TODO Auto-generated method stub
		return replyDAO.list(bno);
	}

	@Override
	public void modifyReply(Reply reply) throws Exception {
		// TODO Auto-generated method stub
		replyDAO.update(reply);
	}

	@Transactional
	@Override
	public void removeReply(Integer rno) throws Exception {
		// TODO Auto-generated method stub
		int bno = replyDAO.getBno(rno);
		replyDAO.delete(rno);
		boardDAO.updateReplyCnt(bno, -1);
	}

	@Override
	public List<Reply> listReplyPage(Integer bno, Criteria cri) throws Exception {

		return replyDAO.listPage(bno, cri);
	}

	@Override
	public int count(Integer bno) throws Exception {

		return replyDAO.count(bno);
	}

}
