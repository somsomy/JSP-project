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

public class NoticeDAO {
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
		
			String sql="select count(*) from notice";
		
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
	
	public List<NoticeBean> getBoardList(int startRow, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<NoticeBean> nbList=new ArrayList<NoticeBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from notice order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeBean nb = new NoticeBean();
				nb.setNum(rs.getInt("num"));
				nb.setName(rs.getString("name"));
				nb.setSubject(rs.getString("subject"));
				nb.setContent(rs.getString("content"));
				nb.setFile(rs.getString("file"));
				nb.setDate(rs.getTimestamp("date"));
				nb.setReadcount(rs.getInt("readcount"));
				
				nbList.add(nb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return nbList;
		
		}
	
	public void insertBoard(NoticeBean nb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
		
			int num=0;
			
			String sql2 = "select max(num) from notice";
			pstmt2=con.prepareStatement(sql2);
		
			rs = pstmt2.executeQuery();
		
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
				
			String sql="insert into notice(num,name,subject,content,date,readcount) values(?,?,?,?,?,?)";
		
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, nb.getName());
			pstmt.setString(3, nb.getSubject());
			pstmt.setString(4, nb.getContent());
			pstmt.setTimestamp(5, nb.getDate());
			pstmt.setInt(6, nb.getReadcount());
		
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
	
	public NoticeBean getBoard(int num) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		NoticeBean nb = new NoticeBean();
		
		try {
			con=getConnection();
			
			String sql="select * from notice where num=?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nb.setNum(rs.getInt("num"));
				nb.setName(rs.getString("name"));
				nb.setSubject(rs.getString("subject"));
				nb.setContent(rs.getString("content"));
				nb.setDate(rs.getTimestamp("date"));
				nb.setReadcount(rs.getInt("readcount"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
		return nb;
		
	}
	
	public void updateReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="update notice set readcount=readcount+1 where num=?";
			
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
	
	public void updateBoard(NoticeBean nb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update notice set subject=?, content=? where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, nb.getSubject());
			pstmt.setString(2, nb.getContent());
			pstmt.setInt(3, nb.getNum());
			
			pstmt.executeUpdate();
			
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
	}
	
	public void deleteBoard(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con = getConnection();
			
			String sql="delete from notice where num=?";
			
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
	
	public int getBoardCount(String search) {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int count=0;
		
		try {
			con=getConnection();

			String sql="select count(*) from notice where subject like ?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%"); 
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
	
	public List<NoticeBean> getBoardList(int startRow, int pageSize, String search) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<NoticeBean> nbList=new ArrayList<NoticeBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from notice where subject like ? order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeBean nb = new NoticeBean();
				nb.setNum(rs.getInt("num"));
				nb.setName(rs.getString("name"));
				nb.setSubject(rs.getString("subject"));
				nb.setContent(rs.getString("content"));
				nb.setDate(rs.getTimestamp("date"));
				nb.setReadcount(rs.getInt("readcount"));
				
				nbList.add(nb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return nbList;
		
		
	}
	
}
