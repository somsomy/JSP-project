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


public class FindBoardDAO {
	public Connection getConnection() throws Exception {

		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");	
		Connection con=ds.getConnection();
		return con;
	}
	
	
	public void insertBoard(FindBoardBean fbb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
		
			int num=0;
			
			String sql2 = "select max(num) from catfind";
			pstmt2=con.prepareStatement(sql2);
		
			rs = pstmt2.executeQuery();
		
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
				
			String sql="insert into catfind values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setString(2, fbb.getName());
			pstmt.setString(3, fbb.getPhone());
			pstmt.setString(4, fbb.getCat());
			pstmt.setString(5, fbb.getReward());
			pstmt.setString(6, fbb.getSubject());
			pstmt.setString(7, fbb.getCatName());
			pstmt.setString(8, fbb.getCatAge());
			pstmt.setString(9, fbb.getCatGender());
			pstmt.setString(10, fbb.getCatDate());
			pstmt.setString(11, fbb.getCatPlace());
			pstmt.setString(12, fbb.getFile());
			pstmt.setString(13, fbb.getContent());
			pstmt.setTimestamp(14, fbb.getDate());
			pstmt.setInt(15, fbb.getReadcount());
		
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
		
			String sql="select count(*) from catfind";
		
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
		
			String sql="select count(*) from catfind where subject like ?";
		
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
	
	public List<FindBoardBean> getBoardList(int startRow, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<FindBoardBean> fbbList=new ArrayList<FindBoardBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from catfind order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				FindBoardBean fbb = new FindBoardBean();
				fbb.setNum(rs.getInt("num"));
				fbb.setName(rs.getString("name"));
				fbb.setPhone(rs.getString("phone"));
				fbb.setCat(rs.getString("cat"));
				fbb.setReward(rs.getString("reward"));
				fbb.setCatName(rs.getString("catname"));
				fbb.setCatAge(rs.getString("catage"));
				fbb.setCatGender(rs.getString("catgender"));
				fbb.setCatDate(rs.getString("catdate"));
				fbb.setCatPlace(rs.getString("catplace"));
				fbb.setFile(rs.getString("file"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
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
	
	public List<FindBoardBean> getBoardList(int startRow, int pageSize, String search) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<FindBoardBean> fbbList=new ArrayList<FindBoardBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from catfind where subject like ? order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				FindBoardBean fbb = new FindBoardBean();
				fbb.setNum(rs.getInt("num"));
				fbb.setName(rs.getString("name"));
				fbb.setPhone(rs.getString("phone"));
				fbb.setCat(rs.getString("cat"));
				fbb.setReward(rs.getString("reward"));
				fbb.setCatName(rs.getString("catname"));
				fbb.setCatAge(rs.getString("catage"));
				fbb.setCatGender(rs.getString("catgender"));
				fbb.setCatDate(rs.getString("catdate"));
				fbb.setCatPlace(rs.getString("catplace"));
				fbb.setFile(rs.getString("file"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
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
	
	public FindBoardBean getBoard(int num) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		FindBoardBean fbb = new FindBoardBean();
		
		try {
			con=getConnection();
			
			String sql="select * from catfind where num=?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				
				fbb.setNum(rs.getInt("num"));
				fbb.setName(rs.getString("name"));
				fbb.setPhone(rs.getString("phone"));
				fbb.setCat(rs.getString("cat"));
				fbb.setReward(rs.getString("reward"));
				fbb.setCatName(rs.getString("catname"));
				fbb.setCatAge(rs.getString("catage"));
				fbb.setCatGender(rs.getString("catgender"));
				fbb.setCatDate(rs.getString("catdate"));
				fbb.setCatPlace(rs.getString("catplace"));
				fbb.setFile(rs.getString("file"));
				fbb.setSubject(rs.getString("subject"));
				fbb.setContent(rs.getString("content"));
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
	
	public void updateReadcount(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="update catfind set readcount=readcount+1 where num=?";
			
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

	public void updateBoard(FindBoardBean fbb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update catfind set cat=?, reward=?, subject=?, catname=?, catage=?, catgender=?, catdate=?, catplace=?, file=?, content=? where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, fbb.getCat());
			pstmt.setString(2, fbb.getReward());
			pstmt.setString(3, fbb.getSubject());
			pstmt.setString(4, fbb.getCatName());
			pstmt.setString(5, fbb.getCatAge());
			pstmt.setString(6, fbb.getCatGender());
			pstmt.setString(7, fbb.getCatDate());
			pstmt.setString(8, fbb.getCatPlace());
			pstmt.setString(9, fbb.getFile());
			pstmt.setString(10, fbb.getContent());
			pstmt.setInt(11, fbb.getNum());
			
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
			
			String sql="delete from catfind where num=?";
			
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
