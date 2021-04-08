package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class VolunteerDAO {
	public Connection getConnection() throws Exception {

		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");	
		Connection con=ds.getConnection();
		return con;
	}
	
	public int getBoardCount() {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int count=0;
	
		try {
			con=getConnection();
		
			String sql="select count(*) from volunteer";
		
			pstmt=con.prepareStatement(sql);
			
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
	
	public List<VolunteerBean> getBoardList(int startRow, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<VolunteerBean> vbList=new ArrayList<VolunteerBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from volunteer order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				VolunteerBean vb = new VolunteerBean();
				vb.setNum(rs.getInt("num"));
				vb.setState(rs.getString("state"));
				vb.setName(rs.getString("name"));
				vb.setSubject(rs.getString("subject"));
				vb.setContent(rs.getString("content"));
				vb.setFile(rs.getString("file"));
				vb.setDate(rs.getTimestamp("date"));
				vb.setReadcount(rs.getInt("readcount"));
				
				vbList.add(vb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return vbList;
		
		}
	
	public void insertBoard(VolunteerBean vb) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		PreparedStatement pstmt2=null;

		try {
			con=getConnection();
		
			int num=0;
			
			String sql = "select max(num) from volunteer";
			pstmt=con.prepareStatement(sql);
		
			rs = pstmt.executeQuery();
		
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
				
			sql="insert into volunteer values(?,?,?,?,?,?,?,?)";
		
			pstmt2=con.prepareStatement(sql);
			
			pstmt2.setInt(1, num);
			pstmt2.setString(2, vb.getState());
			pstmt2.setString(3, vb.getName());
			pstmt2.setString(4, vb.getSubject());
			pstmt2.setString(5, vb.getContent());
			pstmt2.setString(6, vb.getFile());
			pstmt2.setTimestamp(7, vb.getDate());
			pstmt2.setInt(8, vb.getReadcount());
		
			pstmt2.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt2!=null)  try { pstmt2.close(); } catch (SQLException ex) { } 
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null)  try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null)  try { con.close(); } catch (SQLException ex) { } 
		}
	
	}
	
	public void updateReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="update volunteer set readcount=readcount+1 where num=?";
			
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
	
	public VolunteerBean getBoard(int num) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		VolunteerBean vb = new VolunteerBean();
		
		try {
			con=getConnection();
			
			String sql="select * from volunteer where num=?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				vb.setNum(rs.getInt("num"));
				vb.setState(rs.getString("state"));
				vb.setName(rs.getString("name"));
				vb.setSubject(rs.getString("subject"));
				vb.setContent(rs.getString("content"));
				vb.setFile(rs.getString("file"));
				vb.setDate(rs.getTimestamp("date"));
				vb.setReadcount(rs.getInt("readcount"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
		return vb;
		
	}
	
	public void deleteBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con = getConnection();
			
			String sql="delete from volunteer where num=?";
			
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
	
	public void updateBoard(VolunteerBean vb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update volunteer set subject=?, content=?, file=?, state=? where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, vb.getSubject());
			pstmt.setString(2, vb.getContent());
			pstmt.setString(3, vb.getFile());
			pstmt.setString(4, vb.getState());
			pstmt.setInt(5, vb.getNum());
			
			pstmt.executeUpdate();
			
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
	}
}
