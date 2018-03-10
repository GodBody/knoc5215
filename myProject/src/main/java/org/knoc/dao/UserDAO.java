package org.knoc.dao;

import java.util.Date;
import java.util.List;

import org.knoc.domain.Criteria;
import org.knoc.domain.MessageVO;
import org.knoc.domain.UserVO;
import org.knoc.dto.LoginDTO;

public interface UserDAO {
	public UserVO login(LoginDTO dto) throws Exception;

	public void keepLogin(String uid, String sessionId, Date next);

	public UserVO checkUserWithSessionKey(String value);

	public void insertUser(UserVO user) throws Exception;

	public void createAuthKey(String email, String authCode) throws Exception;

	public void userAuth(String email) throws Exception;

	public boolean authCheck(String uid);

	public int emailCheck(UserVO user) throws Exception;

	public String getUserPw(String uemail) throws Exception;

	public String idSearch(UserVO user);

	public int checkUserForPW(UserVO user);

	public void changePW(UserVO user);

	public void sendMessage(MessageVO dto);

	public List<MessageVO> listMessage(UserVO user, Criteria cri);

	public int checkExist(String receiver);

	public int listCountCriteria(Criteria cri);

	public void updateViewCnt(Integer mno);

	public MessageVO read(Integer mno);

	public void removeMessage(Integer mno);

	public int nicknameCheck(String newNickname);

	public void updateNickname(UserVO user);
	
}
