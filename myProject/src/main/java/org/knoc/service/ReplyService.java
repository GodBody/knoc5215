package org.knoc.service;

import java.util.List;

import org.knoc.domain.Criteria;
import org.knoc.domain.Reply;

public interface ReplyService {
	public void addReply(Reply reply) throws Exception;

	public List<Reply> listReply(Integer bno) throws Exception;

	public void modifyReply(Reply reply) throws Exception;

	public void removeReply(Integer rno) throws Exception;

	public List<Reply> listReplyPage(Integer bno, Criteria cri) throws Exception;

	public int count(Integer bno) throws Exception;
}
