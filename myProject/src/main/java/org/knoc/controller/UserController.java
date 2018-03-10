package org.knoc.controller;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.knoc.domain.Criteria;
import org.knoc.domain.MessageVO;
import org.knoc.domain.PageMaker;
import org.knoc.domain.UserVO;
import org.knoc.dto.LoginDTO;
import org.knoc.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
@RequestMapping("/user")
public class UserController {

	private static Logger logger = LoggerFactory.getLogger(UserController.class);

	@Inject
	private UserService service;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public void userHome(Model model, UserVO vo) {
		model.addAttribute("userVO", vo);
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void registerGET(UserVO user, Model model) {
		logger.info("User Register GET");
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String registerPOST(UserVO user, Model model, RedirectAttributes rttr) throws Exception {

		int checkNum = service.emailCheck(user);
		System.out.println("checkNUm = " + checkNum);

		if (checkNum < 1) {

			logger.info("User Register POST");
			logger.info(user.toString());

			service.join(user);

			model.addAttribute("userVO", user);
			model.addAttribute("msg", "AUTH");

			return "/user/home";
		}

		else {
			rttr.addFlashAttribute("msg", "EMAIL_CHECK");
			return "redirect:/user/register";
		}

	}

	@RequestMapping(value = "/emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(String user_email, Model model) throws Exception { // 이메일인증
		service.userAuth(user_email);
		model.addAttribute("user_email", user_email);

		return "/user/emailConfirm";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {

	}

	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public String loginPOST(LoginDTO dto, HttpSession session, Model model, RedirectAttributes rttr) throws Exception {

		UserVO vo = service.login(dto);
		// logger.info(vo.toString());

		boolean authCheck = service.authCheck(vo.getUid());

		if (authCheck == false) {
			rttr.addFlashAttribute("msg", "FAIL");
			return "redirect:/user/home";
		} else {
			model.addAttribute("userVO", vo);
			model.addAttribute("msg", "LOGIN");

			if (dto.isUseCookie()) {
				int amount = 60 * 60 * 24 * 7;

				Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));

				service.keepLogin(vo.getUid(), session.getId(), sessionLimit);
			}

			return "/user/home";
		}

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {
		Object obj = session.getAttribute("login");

		if (obj != null) {
			UserVO vo = (UserVO) obj;

			session.removeAttribute("login");
			session.invalidate();

			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");

			if (loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);

				response.addCookie(loginCookie);

				service.keepLogin(vo.getUid(), session.getId(), new Date());
			}
		}
		return "/user/logout";
	}

	@RequestMapping(value = "/forgetID", method = RequestMethod.GET)
	public void forgetID() {

	}

	@RequestMapping(value = "/idSearch", method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public @ResponseBody String idSearch(@ModelAttribute UserVO user) throws Exception {
		System.out.println(user.toString());

		String findid = service.idSearch(user);
		System.out.println("findid : " + findid);
		String id = "{\"uid\":\"" + findid + "\"}";
		System.out.println("id: " + id);
		return id;
	}

	@RequestMapping(value = "/pwSearch", method = RequestMethod.POST)
	public void pwSearch(@ModelAttribute UserVO user) throws Exception {
		logger.info(user.toString());
		logger.info("pwSearch service into...");

		service.sendMailForPw(user);

	}

	@RequestMapping(value = "/changePW", method = RequestMethod.GET)
	public String changePW(String user_email, Model model) throws Exception { // 이메일인증
		// service.userAuth(user_email);
		model.addAttribute("user_email", user_email);

		return "/user/changePW";
	}

	@RequestMapping(value = "/changePW", method = RequestMethod.POST)
	public String changePW(@ModelAttribute UserVO user, @RequestParam("user_email") String email,
			RedirectAttributes rttr) throws Exception { // 이메일인증

		user.setUemail(email);

		logger.info(user.toString());

		String encPw = passwordEncoder.encode(user.getUpw());
		user.setUpw(encPw);
		System.out.println("암호화된 비밀번호: " + user.getUpw());

		service.changePW(user);

		rttr.addFlashAttribute("msg", "CHANGE");

		return "redirect:/user/home";
	}

	@RequestMapping(value = "/forgetPW", method = RequestMethod.POST)
	public void forgetPWPOST(@ModelAttribute UserVO user, Model model) throws Exception {
		logger.info(user.toString());

	}

	@RequestMapping(value = "/info", method = RequestMethod.GET)
	public void info() {

	}

	@RequestMapping(value = "/message", method = RequestMethod.GET)
	public void messageGET(HttpServletRequest request, Model model, @ModelAttribute("cri") Criteria cri) {

		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("login");

		System.out.println("Session info: " + user.toString());

		List<MessageVO> list = service.listMessage(user, cri);

		for (MessageVO itr : list) {
			System.out.println("MessageVO info : " + itr.toString());
		}

		model.addAttribute("list", list);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCountCriteria(cri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("userVO", user);

	}

	@RequestMapping(value = "/message", method = RequestMethod.POST)
	public String messagePOST(@ModelAttribute MessageVO message, RedirectAttributes rttr, Model model) {
		logger.info(message.toString());

		String receiver = message.getReceiver();

		int exist = service.checkExist(receiver);

		if (exist == 1) {

			service.sendMessage(message);

			rttr.addFlashAttribute("msg", "SEND");

			return "redirect:/user/message";

		}

		else {
			rttr.addFlashAttribute("msg", "SEND_FAIL");

			return "redirect:/user/message";
		}
	}

	@RequestMapping(value = "/messageRead", method = RequestMethod.GET)
	public void messageRead(@RequestParam("mno") int mno, @ModelAttribute("cri") Criteria cri, Model model) {
		model.addAttribute(service.read(mno));
	}

	@RequestMapping(value = "/messageSend", method = RequestMethod.GET)
	public void messageSend(@RequestParam("receiver") String receiver, Model model) {
		model.addAttribute("receiver", receiver);
	}

	@RequestMapping(value = "/messageSend", method = RequestMethod.POST)
	public void messageSend(@ModelAttribute MessageVO message, Model model) {
		logger.info("/messageSend : POST --> " + message.toString());
		service.sendMessage(message);
	}

	@ResponseBody
	@RequestMapping(value = "/messageRemove/{mno}", method = RequestMethod.DELETE)
	public ResponseEntity<String> messageRemove(@PathVariable("mno") Integer mno) {

		ResponseEntity<String> entity = null;
		try {
			service.removeMessage(mno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	/*
	 * Naver Login API
	 */

	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	public void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	// 로그인 첫 화면 요청 메소드
	@RequestMapping(value = "/naverLogin", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {

		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);

		// 네이버
		model.addAttribute("url", naverAuthUrl);

		/* 생성한 인증 URL을 View로 전달 */
		return "/user/naverLogin";
	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException {
		System.out.println("callback -> registerWithNaver.jsp");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 로그인 사용자 정보를 읽어온다.

		apiResult = naverLoginBO.getUserProfile(oauthToken);

		model.addAttribute("result", apiResult);

		return "/user/registerWithNaver";
	}

	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public ModelAndView viewChatPage() {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("/user/chat");

		return mav;
	}

	@RequestMapping(value = "/infoChange", method = RequestMethod.GET)
	public void infoChangeGET() {

	}

	@RequestMapping(value = "/infoChange", method = RequestMethod.POST)
	public void infoChangePOST(@ModelAttribute UserVO user) {
		/* 현재 저장된 암호를 가져와서 encode한 값을 새로운 string에 저장
		 * 새로운 string을 param으로 하여 새로운 비밀번호를 저장 (암호화 된 비밀번호)
		 *  user 객체를 param으로 하여 service 단에 전송
		 * */
		String encPw = passwordEncoder.encode(user.getUpw());
		user.setUpw(encPw);
		
		service.changePW(user);
		service.chageeNickname(user);
	}

	// @RequestMapping(value = "/pwCheck", method = RequestMethod.POST)
	// public String pwCheck(@RequestBody LoginDTO dto) throws Exception {
	// logger.info(dto.toString());
	//
	// String str = service.pwCheck(dto);
	// logger.info(str);
	//
	//
	// return str;
	//
	// }
	@ResponseBody
	@RequestMapping(value = "/pwCheck", method = RequestMethod.POST)
	public ResponseEntity<String> pwCheck(@RequestBody LoginDTO dto) throws Exception {

		ResponseEntity<String> entity = null;

		try {
			entity = new ResponseEntity<String>(service.pwCheck(dto), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

		return entity;

	}

	@ResponseBody
	@RequestMapping(value = "/nicknameCheck", method = RequestMethod.POST)
	public ResponseEntity<String> nicknameCheck(@RequestBody UserVO user) throws Exception {

		String result = service.nicknameCheck(user);
		ResponseEntity<String> entity = null;

		try {
			if (result == "success")
				entity = new ResponseEntity<String>(result, HttpStatus.OK);
			else
				entity = new ResponseEntity<String>(result, HttpStatus.FORBIDDEN);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

		return entity;

	}
	

}
