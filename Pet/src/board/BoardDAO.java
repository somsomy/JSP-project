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

public class BoardDAO {
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
			
				String sql="select count(*) from adoptboard";
			
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

	public List<BoardBean> getBoardList(int startRow, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<BoardBean> bbList=new ArrayList<BoardBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from adoptboard order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setCatName(rs.getString("catname"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadcount(rs.getInt("readcount"));
				
				bbList.add(bb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return bbList;
		
		}

	public void insertBoard(BoardBean bb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
		
			int num=0;
			
			String sql2 = "select max(num) from adoptboard";
			pstmt2=con.prepareStatement(sql2);
		
			rs = pstmt2.executeQuery();
		
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
				
			String sql="insert into adoptboard values(?,?,?,?,?,?,?)";
		
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getCatName());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setTimestamp(6, bb.getDate());
			pstmt.setInt(7, bb.getReadcount());
		
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
	
	public BoardBean getBoard(int num) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		BoardBean bb = new BoardBean();
		
		try {
			con=getConnection();
			
			String sql="select * from adoptboard where num=?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setCatName(rs.getNString("catname"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadcount(rs.getInt("readcount"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
		return bb;
		
	}
	
	public void updateReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="update adoptboard set readcount=readcount+1 where num=?";
			
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
	
	public void updateBoard(BoardBean bb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update adoptboard set subject=?, content=? where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, bb.getSubject());
			pstmt.setString(2, bb.getContent());
			pstmt.setInt(3, bb.getNum());
			
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
			
			String sql="delete from adoptboard where num=?";
			
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

			String sql="select count(*) from adoptboard where subject like ?";
			
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
	
	public List<BoardBean> getBoardList(int startRow, int pageSize, String search) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<BoardBean> bbList=new ArrayList<BoardBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from adoptboard where subject like ? order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setCatName(rs.getString("catname"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setReadcount(rs.getInt("readcount"));
				
				bbList.add(bb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return bbList;
		
		
	}
}
