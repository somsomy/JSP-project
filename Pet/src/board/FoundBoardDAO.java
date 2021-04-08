package board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FoundBoardDAO {
	
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
		
			String sql="select count(*) from catfound";
		
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
	
	public int getBoardCount(String search) {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int count=0;
	
		try {
			con=getConnection();
		
			String sql="select count(*) from catfound where subject like ?";
		
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
	
	
	public List<FoundBoardBean> getBoardList(int startRow, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<FoundBoardBean> fbbList=new ArrayList<FoundBoardBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from catfound order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				FoundBoardBean fbb = new FoundBoardBean();
				fbb.setNum(rs.getInt("num"));
				fbb.setName(rs.getString("name"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
				fbb.setFile(rs.getString("file"));
				fbb.setDate(rs.getTimestamp("date"));
				fbb.setReadcount(rs.getInt("readcount"));
				
				fbbList.add(fbb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return fbbList;
		
		}
	
	public List<FoundBoardBean> getBoardList(int startRow, int pageSize, String search) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<FoundBoardBean> fbbList=new ArrayList<FoundBoardBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from catfound where subject like ? order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				FoundBoardBean fbb = new FoundBoardBean();
				fbb.setNum(rs.getInt("num"));
				fbb.setName(rs.getString("name"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
				fbb.setFile(rs.getString("file"));
				fbb.setDate(rs.getTimestamp("date"));
				fbb.setReadcount(rs.getInt("readcount"));
				
				fbbList.add(fbb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return fbbList;
		
		}
	
	
	
	
	public void insertBoard(FoundBoardBean fbb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
		
			int num=0;
			
			String sql2 = "select max(num) from catfound";
			pstmt2=con.prepareStatement(sql2);
		
			rs = pstmt2.executeQuery();
		
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
				
			String sql="insert into catfound values(?,?,?,?,?,?,?)";
		
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, fbb.getName());
			pstmt.setString(3, fbb.getSubject());
			pstmt.setString(4, fbb.getContent());
			pstmt.setString(5, fbb.getFile());
			pstmt.setTimestamp(6, fbb.getDate());
			pstmt.setInt(7, fbb.getReadcount());
		
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
	
	public void updateReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="update catfound set readcount=readcount+1 where num=?";
			
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
	
	public FoundBoardBean getBoard(int num) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		FoundBoardBean fbb = new FoundBoardBean();
		
		try {
			con=getConnection();
			
			String sql="select * from catfound where num=?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				fbb.setNum(rs.getInt("num"));
				fbb.setName(rs.getString("name"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
				fbb.setFile(rs.getString("file"));
				fbb.setDate(rs.getTimestamp("date"));
				fbb.setReadcount(rs.getInt("readcount"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
		return fbb;
		
	}
	
	
	public void updateBoard(FoundBoardBean fbb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update catfound set subject=?, content=?, file=? where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, fbb.getSubject());
			pstmt.setString(2, fbb.getContent());
			pstmt.setString(3, fbb.getFile());
			pstmt.setInt(4, fbb.getNum());
			
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
			
			String sql="delete from catfound where num=?";
			
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
	
    public void deleteFile(String uploadPath, String fileName) {
        String path = uploadPath + "\\" + fileName;
        File deleteFile = new File(path);
        if(deleteFile.exists()) {
            
            deleteFile.delete(); 
            
        } else {
            System.out.println("파일이 존재하지 않습니다.");
        }
    }
}
