package org.knoc.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
@Service
public class UserService implements UserDetailsService {

	@Autowired
	private UserAuthDAO dao;

	@Override
	public UserDetails loadUserByUsername(String userid) throws UsernameNotFoundException {

		UserDetails userDetails = dao.getUserDetails(userid);

		if (userDetails == null)
			throw new UsernameNotFoundException("not found user_info");

		return userDetails;
	}

}
