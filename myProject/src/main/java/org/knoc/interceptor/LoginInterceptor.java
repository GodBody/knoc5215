package org.knoc.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final String LOGIN = "login";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub

		HttpSession session = request.getSession();

		if (session.getAttribute(LOGIN) != null) { // 기존 세션에 정보가 남아있는 경우
			logger.info("Clear login data BEFORE");
			session.removeAttribute(LOGIN); // 삭제
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		HttpSession session = request.getSession();

		ModelMap modelMap = modelAndView.getModelMap();

		Object userVO = modelMap.get("userVO"); // 컨트롤러에서 받은 userVO를

		if (userVO != null) {
			logger.info("New Login SUCCESS");
			session.setAttribute(LOGIN, userVO); // 세션에 저장

			if (request.getParameter("useCookie") != null) {

				logger.info("REMEMBER ME..........");

				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(loginCookie);
			}

			// response.sendRedirect("/");

			Object dest = session.getAttribute("dest");

			response.sendRedirect(dest != null ? (String) dest : "/user/home");
		}
	}

}
