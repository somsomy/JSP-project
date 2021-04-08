package supporter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;
import cats.CatsBean;
import member.MemberBean;

public class SupporterDAO {
	public Connection getConnection() throws Exception {
		
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	public void insertSupporter(SupporterBean sb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
		
			int num=0;
			
			String sql2 = "select max(num) from supporter";
			pstmt2=con.prepareStatement(sql2);
		
			rs = pstmt2.executeQuery();
		
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
				
			String sql="insert into supporter values(?,?,?,?,?,?,?,?,?,?,?)";
		
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, sb.getUserid());
			pstmt.setInt(3, sb.getCatId());
			pstmt.setString(4, sb.getSupportType());
			pstmt.setString(5, sb.getDonation());
			pstmt.setString(6, sb.getYearDonation());
			pstmt.setString(7, sb.getPayment());
			pstmt.setString(8, sb.getPayNum());
			pstmt.setString(9, sb.getYear()+sb.getMonth()+sb.getDay());
			pstmt.setString(10, sb.getOwnerName());
			pstmt.setTimestamp(11, sb.getDate());
		
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null)  try { pstmt.close(); } catch (SQLException ex) { } 
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt2!=null)  try { pstmt2.close(); } catch (SQLException ex) { } 
			if(con!=null)  try { con.close(); } catch (SQLException ex) { } 

		}
	
	}
	
	public List<SupporterBean> getCatsList(int startRow, int pageSize, String id) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<SupporterBean> sbList=new ArrayList<SupporterBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from supporter where userid=? order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				SupporterBean sb=new SupporterBean();
				sb.setNum(rs.getInt("num"));
				sb.setCatId(rs.getInt("catid"));
				sb.setSupportType(rs.getString("supporttype"));
				sb.setDonation(rs.getString("donation"));
				sb.setYearDonation(rs.getString("yeardonation"));
				sb.setPayment(rs.getString("payment"));
				sb.setPayNum(rs.getString("paynum"));
				sb.setSupportStart(rs.getString("supportstart"));
				sb.setOwnerName(rs.getString("ownername"));
				sb.setDate(rs.getTimestamp("date"));
				
				sbList.add(sb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return sbList;
		
		}
	
	
	public int getCatsCount(String id) {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int count=0;
	
		try {
			con=getConnection();
		
			String sql="select count(*) from supporter where userid=?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
		
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
	
		return count;
	}
	
	public SupporterBean getSupporter(int id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		SupporterBean sb=new SupporterBean();
		
		try {
			con=getConnection();
			
			String sql="select * from supporter where userid=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				sb.setNum(rs.getInt("num"));
				sb.setCatId(rs.getInt("catid"));
				sb.setSupportType(rs.getString("supporttype"));
				sb.setDonation(rs.getString("donation"));
				sb.setYearDonation(rs.getString("yeardonation"));
				sb.setPayment(rs.getString("payment"));
				sb.setPayNum(rs.getString("paynum"));
				sb.setSupportStart(rs.getString("supportstart"));
				sb.setOwnerName(rs.getString("ownername"));
				sb.setDate(rs.getTimestamp("date"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}
		
		return sb;
	}
	
	public SupporterBean getBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		SupporterBean sb=new SupporterBean();
		
		try {
			con=getConnection();
			
			String sql="select * from supporter where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				sb.setUserid(rs.getString("userid"));
				sb.setCatId(rs.getInt("catid"));
				sb.setSupportType(rs.getString("supporttype"));
				sb.setDonation(rs.getString("donation"));
				sb.setYearDonation(rs.getString("yeardonation"));
				sb.setPayment(rs.getString("payment"));
				sb.setPayNum(rs.getString("paynum"));
				sb.setSupportStart(rs.getString("supportstart"));
				sb.setOwnerName(rs.getString("ownername"));
				sb.setDate(rs.getTimestamp("date"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}
		
		return sb;
	}
	
	public void updateSupporter(SupporterBean sb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update supporter set supporttype=?,donation=?,yeardonation=?,payment=?,paynum=?,supportstart=?,ownername=? where num=?";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, sb.getSupportType());
			pstmt.setString(2, sb.getDonation());
			pstmt.setString(3, sb.getYearDonation());
			pstmt.setString(4, sb.getPayment());
			pstmt.setString(5, sb.getPayNum());
			pstmt.setString(6, sb.getYear()+sb.getMonth()+sb.getDay());
			pstmt.setString(7, sb.getOwnerName());
			pstmt.setInt(8, sb.getNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}

	}
	
	public void deleteBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con = getConnection();
			
			String sql="delete from supporter where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
	}
}
