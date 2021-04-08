package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.Pattern;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	public Connection getConnection() throws Exception {
		
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public void insertMember(MemberBean mb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
		
			String sql="insert into member values(?,?,?,?,?,?,?,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getNick());
			pstmt.setString(5, mb.getEmailId() + "@" + mb.getEmail());
			pstmt.setString(6, mb.getPhone1() + mb.getPhone2() + mb.getPhone3());
			pstmt.setString(7, mb.getPostCode());
			pstmt.setString(8, mb.getAddress() + mb.getExtraAddress());
			pstmt.setString(9, mb.getDetailAddress());
			pstmt.setTimestamp(10, mb.getDate());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}

	}
	
	
	public int userCheck(String id, String pass) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int check = -1;
		
		try {
			con=getConnection();
			
			String sql="select * from member where id=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					check = 1;
				} else {
					check = 0;
				}
			} else {
				check = -1;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}
		
		return check;
	}
	
	public MemberBean getMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MemberBean mb=new MemberBean();
		
		try {
			con=getConnection();
			
			String sql="select * from member where id=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				mb.setId(rs.getString("id"));
				mb.setName(rs.getString("name"));
				mb.setNick(rs.getString("nick"));
				mb.setEmail(rs.getString("email"));
				mb.setPhone(rs.getString("phone"));
				mb.setPostCode(rs.getString("postcode"));
				mb.setAddress(rs.getString("address"));
				mb.setDetailAddress(rs.getString("detailaddress"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}
		
		return mb;
	}
	
	public void updateMember(MemberBean mb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update member set name=?,nick=?,email=?,phone=?,postcode=?,address=?,detailaddress=?,nick=? where id=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getName());
			pstmt.setString(2, mb.getNick());
			pstmt.setString(3, mb.getEmail());
			pstmt.setString(4, mb.getPhone());
			pstmt.setString(5, mb.getPostCode());
			pstmt.setString(6, mb.getAddress());
			pstmt.setString(7, mb.getDetailAddress());
			pstmt.setString(8, mb.getNick());
			pstmt.setString(9, mb.getId());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}

	}
	
	public int passCheck(String pass) {
		String lengthRegex="[A-Za-z0-9!@#]{8,16}";
		String engUpperRegex="[A-Z]";
		String engLowerRegex="[a-z]";
		String numRegex="[0-9]";
		String specRegex="[!@#]";
		
		int check = 0;
		
		if(Pattern.matches(lengthRegex, pass)) {
			check += Pattern.compile(engUpperRegex).matcher(pass).find() ? 1 : 0;
			check += Pattern.compile(engLowerRegex).matcher(pass).find() ? 1 : 0;
			check += Pattern.compile(numRegex).matcher(pass).find() ? 1 : 0;
			check += Pattern.compile(specRegex).matcher(pass).find() ? 1 : 0;
			
		} else {
			check = 0;
		}
			
		return check;
	}
	
	public int idCheck(String id) {
		String lengthRegex="[a-z0-9_]{5,20}";
		String engLowerRegex="[a-z]";
		String numRegex="[0-9]";
		String specRegex="[_]";
		
		int check = 0;
		
		if(Pattern.matches(lengthRegex, id)) {
			check += Pattern.compile(engLowerRegex).matcher(id).find() ? 1 : 0;
			check += Pattern.compile(numRegex).matcher(id).find() ? 1 : 0;
			check += Pattern.compile(specRegex).matcher(id).find() ? 1 : 0;
			
		} else {
			check = 0;
		}
			
		return check;
	}
	
	public int idDupCheck(String id) {
		int check=1;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			
			con=getConnection();
			
			String sql="select * from member where id=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				check=1;
			} else {
				check=-1;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}
		
		return check;
	}
	
	public int nickCheck(String nick) {
		String lengthRegex="[A-za-z0-9가-힣]{1,10}";
		String engUpperRegex="[A-Z]";
		String engLowerRegex="[a-z]";
		String numRegex="[0-9]";
		String korean="[가-힣]";
		
		int check = 0;
		
		if(Pattern.matches(lengthRegex, nick)) {
			check += Pattern.compile(engUpperRegex).matcher(nick).find() ? 1 : 0;
			check += Pattern.compile(engLowerRegex).matcher(nick).find() ? 1 : 0;
			check += Pattern.compile(numRegex).matcher(nick).find() ? 1 : 0;
			check += Pattern.compile(korean).matcher(nick).find() ? 1 : 0;

		} else {
			check = 0;
		}
			
		return check;
	}
	
	public int nickDupCheck(String nick) {
		int check=1;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			
			con=getConnection();
			
			String sql="select * from member where nick=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, nick);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				check=1;
			} else {
				check=-1;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}
		
		return check;
	}
	
	public int myPgaeNickDupCheck(String nick, String id) {
		int check=1;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			
			con=getConnection();
			
			String sql="select * from member where nick=? and not id=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, nick);
			pstmt.setString(2, id);

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				check=1;
			} else {
				check=-1;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}
		
		return check;
	}
	
}
