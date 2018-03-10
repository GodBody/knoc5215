package org.knoc.service;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.knoc.dao.UserDAO;
import org.knoc.domain.Criteria;
import org.knoc.domain.MessageVO;
import org.knoc.domain.UserVO;
import org.knoc.dto.LoginDTO;
import org.knoc.util.MailHandler;
import org.knoc.util.TempKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;

	@Inject
	private JavaMailSender mailSender;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public UserVO login(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		String uid = dto.getUid();

		String pw = dao.getUserPw(uid);
		System.out.println("암호화된 비밀번호 :" + pw);

		String rawPw = dto.getUpw();
		System.out.println("비밀번호: " + rawPw);

		if (passwordEncoder.matches(rawPw, pw)) {
			System.out.println("일치");
			dto.setUpw(pw);
		} else {
			System.out.println("불일치");
		}

		return dao.login(dto);
	}

	@Override
	public String pwCheck(LoginDTO dto) throws Exception {
		// TODO Auto-generated method stub
		String uid = dto.getUid();

		String pw = dao.getUserPw(uid);
		System.out.println("암호화된 비밀번호 :" + pw);

		String rawPw = dto.getUpw();
		System.out.println("비밀번호: " + rawPw);

		if (passwordEncoder.matches(rawPw, pw)) {
			System.out.println("일치");
			return "success";
		} else {
			System.out.println("불일치");
			return "fail";
		}

	}

	@Override
	public void keepLogin(String uid, String sessionId, Date next) throws Exception {
		// TODO Auto-generated method stub
		dao.keepLogin(uid, sessionId, next);
	}

	@Override
	public UserVO checkLoginBefore(String value) {
		// TODO Auto-generated method stub
		return dao.checkUserWithSessionKey(value);
	}

	@Transactional
	@Override
	public void join(UserVO user) throws Exception {
		// TODO Auto-generated method stub

		String encPw = passwordEncoder.encode(user.getUpw());
		user.setUpw(encPw);
		System.out.println("암호화된 비밀번호: " + user.getUpw());

		dao.insertUser(user);

		String key = new TempKey().getKey(50, false);

		dao.createAuthKey(user.getUemail(), key);

		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("[MyProject EMAIL AUTH]");
		sendMail.setText(new StringBuffer().append("<h1>EMAIL AUTH PROCESS</h1>")
				.append("<a href='http://localhost:8080/user/emailConfirm?user_email=").append(user.getUemail())
				.append("&key=").append(key).append("' target='_blenk'>Click here for auth</a>").toString());
		sendMail.setFrom("knoc3885@gmail.com", "Admin");
		sendMail.setTo(user.getUemail());
		sendMail.send();

	}

	@Transactional
	@Override
	public void sendMailForPw(UserVO user) throws Exception {
		// TODO Auto-generated method stub

		String key = new TempKey().getKey(50, false);

		int checkNum = dao.checkUserForPW(user);

		if (checkNum == 1) {
			dao.createAuthKey(user.getUemail(), key);

			MailHandler sendMail = new MailHandler(mailSender);
			sendMail.setSubject("[MyProject Find Password]");
			sendMail.setText(new StringBuffer().append("<h1>Click here to find Password</h1>")
					.append("<a href='http://localhost:8080/user/changePW?user_email=").append(user.getUemail())
					.append("&key=").append(key).append("' target='_blenk'>Click here to find Password</a>")
					.toString());
			sendMail.setFrom("knoc3885@gmail.com", "Admin");
			sendMail.setTo(user.getUemail());
			sendMail.send();

		}
	}

	@Override
	public void userAuth(String email) throws Exception {
		// TODO Auto-generated method stub
		dao.userAuth(email);
	}

	@Override
	public boolean authCheck(String uid) throws Exception {
		// TODO Auto-generated method stub
		return dao.authCheck(uid);
	}

	@Override
	public int emailCheck(UserVO user) throws Exception {
		// TODO Auto-generated method stub
		return dao.emailCheck(user);
	}

	@Override
	public String idSearch(UserVO user) {
		// TODO Auto-generated method stub
		return dao.idSearch(user);
	}

	@Override
	public void changePW(UserVO user) {
		// TODO Auto-generated method stub
		dao.changePW(user);
	}

	@Override
	public void sendMessage(MessageVO dto) {
		// TODO Auto-generated method stub
		dao.sendMessage(dto);
	}

	@Override
	public List<MessageVO> listMessage(UserVO user, Criteria cri) {
		// TODO Auto-generated method stub
		return dao.listMessage(user, cri);
	}

	@Override
	public int checkExist(String receiver) {
		// TODO Auto-generated method stub
		return dao.checkExist(receiver);
	}

	@Override
	public int listCountCriteria(Criteria cri) {
		// TODO Auto-generated method stub
		return dao.listCountCriteria(cri);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public MessageVO read(Integer mno) {
		// TODO Auto-generated method stub
		dao.updateViewCnt(mno);
		return dao.read(mno);
	}

	@Override
	public void removeMessage(Integer mno) {
		// TODO Auto-generated method stub
		dao.removeMessage(mno);
	}

	@Override
	public String nicknameCheck(UserVO user) {
		// TODO Auto-generated method stub
		
		String newNickname = user.getUnickname();
		
		int count = dao.nicknameCheck(newNickname);
		if (count > 1) {
			return "overlap";
		} else {
//			dao.updateNickname(user);
			return "success";
		}
	}

	@Override
	public void chageeNickname(UserVO user) {
		// TODO Auto-generated method stub
		dao.updateNickname(user);
	}

}
