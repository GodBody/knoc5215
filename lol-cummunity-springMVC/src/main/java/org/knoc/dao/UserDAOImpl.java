package org.knoc.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.knoc.domain.Criteria;
import org.knoc.domain.MessageVO;
import org.knoc.domain.UserVO;
import org.knoc.dto.LoginDTO;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession session;

	private static String namespace = "org.knoc.mapper.UserMapper";

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".login", dto);
	}

	@Override
	public void keepLogin(String uid, String sessionId, Date next) {
		// TODO Auto-generated method stub
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("uid", uid);
		paramMap.put("sessionId", sessionId);
		paramMap.put("next", next);

		session.update(namespace + ".keepLogin", paramMap);
	}

	@Override
	public UserVO checkUserWithSessionKey(String value) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".checkUserWithSessionKey", value);
	}

	@Override
	public void insertUser(UserVO user) throws Exception {
		// TODO Auto-generated method stub
		session.insert(namespace + ".insertUser", user);
	}

	@Override
	public void createAuthKey(String email, String authCode) throws Exception {
		// TODO Auto-generated method stub
		UserVO vo = new UserVO();
		vo.setAuthCode(authCode);
		vo.setUemail(email);

		session.selectOne(namespace + ".createAuthKey", vo);
	}

	@Override
	public void userAuth(String email) throws Exception {
		// TODO Auto-generated method stub
		session.update(namespace + ".userAuth", email);
	}

	@Override
	public boolean authCheck(String uid) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".authCheck", uid);
	}

	@Override
	public int emailCheck(UserVO user) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".emailCheck", user);
	}

	@Override
	public String getUserPw(String uemail) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".getUserPw", uemail);
	}

	@Override
	public String idSearch(UserVO user) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".idSearch", user);
	}

	@Override
	public int checkUserForPW(UserVO user) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".checkUserForPW", user);
	}

	@Override
	public void changePW(UserVO user) {
		// TODO Auto-generated method stub
		session.update(namespace + ".changePW", user);
	}

	@Override
	public void sendMessage(MessageVO dto) {
		// TODO Auto-generated method stub
		session.insert(namespace + ".sendMessage", dto);
	}

	@Override
	public List<MessageVO> listMessage(UserVO user, Criteria cri) {
		// TODO Auto-generated method stub

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("user", user);
		paramMap.put("cri", cri);
		return session.selectList(namespace + ".listMessage", paramMap);
	}

	@Override
	public int checkExist(String receiver) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".checkExist", receiver);
	}

	@Override
	public int listCountCriteria(Criteria cri) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".countPaging", cri);
	}

	@Override
	public void updateViewCnt(Integer mno) {
		// TODO Auto-generated method stub
		session.update(namespace + ".updateViewCnt", mno);
	}

	@Override
	public MessageVO read(Integer mno) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace + ".read", mno);
	}

	@Override
	public void removeMessage(Integer mno) {
		// TODO Auto-generated method stub
		session.delete(namespace+".removeMessage", mno);
	}

	@Override
	public int nicknameCheck(String newNickname) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".nicknameCheck", newNickname);

}

	@Override
	public void updateNickname(UserVO user) {
		// TODO Auto-generated method stub
		session.update(namespace+".updateNickname", user);
	}
}