package org.knoc.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
public class UserAuthDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	@Autowired
	private DataSource dataSource;

	private Connection getConn() {
		try {
			conn = dataSource.getConnection();
			return conn;
		} catch (Exception e) {
			e.printStackTrace();
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
					sqle.printStackTrace();
				}
			}
		}
		return null;
	}

	private void closeAll() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException sqle) {
			sqle.printStackTrace();
		}
	}

	public UserDetails getUserDetails(String userId) {
		conn = getConn();
		String sql = "SELECT uid,upw,authority FROM tbl_user WHERE uid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if (rs.next()) {

				String id = rs.getString("uid");
				String pwd = rs.getString("upw");
				String role = rs.getString("authority");

				List<GrantedAuthority> roles = new ArrayList<>();
				roles.add(new SimpleGrantedAuthority(role));
				User user = new User(id, pwd, roles);
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}

		return null;
	}

}
