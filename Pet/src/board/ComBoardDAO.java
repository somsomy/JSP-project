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

public class ComBoardDAO {
	public Connection getConnection() throws Exception {

		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");	
		Connection con=ds.getConnection();
		return con;
	}
	
	public void insertBoard(ComBoardBean cbb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
		
			int num=0;
			
			String sql2 = "select max(num) from comboard";
			pstmt2=con.prepareStatement(sql2);
		
			rs = pstmt2.executeQuery();
		
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
				
			String sql="insert into comboard values(?,?,?,?,?,?,?,?)";
		
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, cbb.getFileName());
			pstmt.setString(3, cbb.getFileRealName());
			pstmt.setString(4, cbb.getSubject());
			pstmt.setString(5, cbb.getContent());
			pstmt.setString(6, cbb.getName());
			pstmt.setTimestamp(7, cbb.getDate());
			pstmt.setInt(8, cbb.getReadcount());
		
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
	
	public int getBoardCount() {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int count=0;
	
		try {
			con=getConnection();
		
			String sql="select count(*) from comboard";
		
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
		
			String sql="select count(*) from comboard where subject like ?";
		
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
	
	public List<ComBoardBean> getBoardList(int startRow, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<ComBoardBean> cbbList=new ArrayList<ComBoardBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from comboard order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ComBoardBean cbb = new ComBoardBean();
				cbb.setNum(rs.getInt("num"));
				cbb.setFileName(rs.getString("filename"));
				cbb.setFileRealName(rs.getString("fileRealname"));
				cbb.setSubject(rs.getString("subject"));
				cbb.setContent(rs.getString("content"));
				cbb.setName(rs.getString("name"));
				cbb.setDate(rs.getTimestamp("date"));
				cbb.setReadcount(rs.getInt("readcount"));
				
				cbbList.add(cbb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return cbbList;
		
		}
	
	public List<ComBoardBean> getBoardList(int startRow, int pageSize, String search) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<ComBoardBean> cbbList=new ArrayList<ComBoardBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from comboard where subject like ? order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ComBoardBean cbb = new ComBoardBean();
				cbb.setNum(rs.getInt("num"));
				cbb.setFileName(rs.getString("filename"));
				cbb.setFileRealName(rs.getString("fileRealname"));
				cbb.setSubject(rs.getString("subject"));
				cbb.setContent(rs.getString("content"));
				cbb.setName(rs.getString("name"));
				cbb.setDate(rs.getTimestamp("date"));
				cbb.setReadcount(rs.getInt("readcount"));
				
				cbbList.add(cbb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return cbbList;
		
		}
	
	
	public void updateReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="update comboard set readcount=readcount+1 where num=?";
			
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
	
	public ComBoardBean getBoard(int num) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		ComBoardBean cbb = new ComBoardBean();
		
		try {
			con=getConnection();
			
			String sql="select * from comboard where num=?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cbb.setNum(rs.getInt("num"));
				cbb.setFileName(rs.getString("filename"));
				cbb.setFileRealName(rs.getString("filerealname"));
				cbb.setName(rs.getString("name"));
				cbb.setSubject(rs.getString("subject"));
				cbb.setContent(rs.getString("content"));
				cbb.setDate(rs.getTimestamp("date"));
				cbb.setReadcount(rs.getInt("readcount"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
		return cbb;
		
	}
	
	public void uploadImageDel(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update comboard set filename=null, filerealname=null where num=?";
			
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
	
	public void updateFileBoard(ComBoardBean cbb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update comboard set filename=?, filerealname=?, subject=?, content=? where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cbb.getFileName());
			pstmt.setString(2, cbb.getFileRealName());
			pstmt.setString(3, cbb.getSubject());
			pstmt.setString(4, cbb.getContent());
			pstmt.setInt(5, cbb.getNum());
			
			pstmt.executeUpdate();
			
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
	}
	
	public void updateBoard(ComBoardBean cbb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update comboard set subject=?, content=? where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cbb.getSubject());
			pstmt.setString(2, cbb.getContent());
			pstmt.setInt(3, cbb.getNum());
			
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
			
			String sql="delete from comboard where num=?";
			
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
