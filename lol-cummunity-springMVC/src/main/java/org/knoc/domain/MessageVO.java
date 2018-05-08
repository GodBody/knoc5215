package org.knoc.domain;

import java.util.Date;

public class MessageVO {
	private Integer mno;

	public Integer getMno() {
		return mno;
	}

	public void setMno(Integer mno) {
		this.mno = mno;
	}

	private String sender;
	private String receiver;
	private String content;
	private Date regdate;
	private int viewcnt;

	public int getViewcnt() {
		return viewcnt;
	}

	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "MessageVO [mno=" + mno + ", sender=" + sender + ", receiver=" + receiver + ", content=" + content
				+ ", regdate=" + regdate + ", viewcnt=" + viewcnt + "]";
	}

}
