package org.knoc.service;

import java.util.Date;
import java.util.List;

import org.knoc.domain.Criteria;
import org.knoc.domain.MessageVO;
import org.knoc.domain.UserVO;
import org.knoc.dto.LoginDTO;

public interface UserService {
	public UserVO login(LoginDTO dto) throws Exception;

	public void keepLogin(String uid, String sessionId, Date next) throws Exception;

	public UserVO checkLoginBefore(String value);

	public void join(UserVO user) throws Exception;

	public void userAuth(String email) throws Exception;

	public boolean authCheck(String uid) throws Exception;

	public int emailCheck(UserVO user) throws Exception;

	public String idSearch(UserVO user);

	public void sendMailForPw(UserVO user) throws Exception;

	public void changePW(UserVO user);

	public void sendMessage(MessageVO dto);

	public List<MessageVO> listMessage(UserVO user, Criteria cri);

	public int checkExist(String receiver);

	public int listCountCriteria(Criteria cri);

	public MessageVO read(Integer mno);

	public void removeMessage(Integer mno);

	public String pwCheck(LoginDTO dto) throws Exception;

	public String nicknameCheck(UserVO user);

	public void chageeNickname(UserVO user);

}
