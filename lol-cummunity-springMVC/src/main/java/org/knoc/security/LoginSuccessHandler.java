package org.knoc.security;

import java.io.IOException;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.knoc.domain.UserVO;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Inject
	private SqlSession sqlSession;

	private static String namespace = "org.knoc.mapper.UserMapper";

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();

		String userName = (String) authentication.getPrincipal();

		UserVO user = sqlSession.selectOne(namespace + ".loginWithUID", userName);

		session.setAttribute("login", user);

		System.out.println(user.toString());

		response.sendRedirect("/user/home");
	}

}
