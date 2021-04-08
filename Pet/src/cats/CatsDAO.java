package cats;

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

import board.BoardBean;
import member.MemberBean;

public class CatsDAO {
	public Connection getConnection() throws Exception {

		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");	
		Connection con=ds.getConnection();
		return con;
	}
	
	public void insertBoard(CatsBean cb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
		
			int catid=0;
			
			String sql2 = "select max(catid) from cats";
			pstmt2=con.prepareStatement(sql2);
		
			rs = pstmt2.executeQuery();
		
			if(rs.next()) {
				catid = rs.getInt("max(catid)") + 1;
			}
				
			String sql="insert into cats values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, catid);
			pstmt.setString(2, cb.getCatName());
			pstmt.setString(3, cb.getCatAge());
			pstmt.setString(4, cb.getCatGender());
			pstmt.setString(5, cb.getCatNeuter());
			pstmt.setString(6, cb.getCatDate());
			pstmt.setString(7, cb.getCatVaccination());
			pstmt.setString(8, cb.getCatIng());
			pstmt.setString(9, cb.getCatInfo());
			pstmt.setString(10, cb.getFileName());
			pstmt.setString(11, cb.getFileRealName());
			pstmt.setTimestamp(12, cb.getDate());
			pstmt.setInt(13, cb.getReadcount());
			
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
	
	public void updateReadcount(int catId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="update cats set readcount=readcount+1 where catid=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, catId);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
	}
	
	public int getBoardCount() {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int count=0;
	
		try {
			con=getConnection();
		
			String sql="select count(*) from cats";
		
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
	
	public int getBoardCount(String ing) {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int count=0;
	
		try {
			con=getConnection();
		
			String sql="select count(*) from cats where cat_ing=?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, ing);
			
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
	
	
	public List<CatsBean> getCatList(int startRow, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<CatsBean> cbList=new ArrayList<CatsBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from cats order by catid desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CatsBean cb = new CatsBean();
				cb.setCatId(rs.getInt("catid"));
				cb.setCatName(rs.getString("catname"));
				cb.setCatAge(rs.getString("catage"));
				cb.setCatGender(rs.getString("catgender"));
				cb.setCatNeuter(rs.getString("catneuter"));
				cb.setCatVaccination(rs.getString("catvaccination"));
				cb.setCatIng(rs.getString("cat_ing"));
				cb.setCatInfo(rs.getString("catinfo"));
				cb.setCatDate(rs.getString("catdate"));
				cb.setFileRealName(rs.getString("fileRealName"));
				cb.setDate(rs.getTimestamp("date"));
				cb.setReadcount(rs.getInt("readcount"));
				
				cbList.add(cb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return cbList;
		
		}
	
	public List<CatsBean> getProtectList(int startRow, int pageSize, String ing) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<CatsBean> cbList=new ArrayList<CatsBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from cats where cat_ing=? order by catid desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, ing);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CatsBean cb = new CatsBean();
				cb.setCatId(rs.getInt("catid"));
				cb.setCatName(rs.getString("catname"));
				cb.setCatAge(rs.getString("catage"));
				cb.setCatGender(rs.getString("catgender"));
				cb.setCatNeuter(rs.getString("catneuter"));
				cb.setCatVaccination(rs.getString("catvaccination"));
				cb.setCatIng(rs.getString("cat_ing"));
				cb.setCatInfo(rs.getString("catinfo"));
				cb.setCatDate(rs.getString("catdate"));
				cb.setFileRealName(rs.getString("fileRealName"));
				cb.setDate(rs.getTimestamp("date"));
				cb.setReadcount(rs.getInt("readcount"));

				cbList.add(cb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return cbList;
		
		}
	
	public List<CatsBean> getProtectList(String ing) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<CatsBean> cbList=new ArrayList<CatsBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from cats where cat_ing=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, ing);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				CatsBean cb = new CatsBean();
				cb.setCatId(rs.getInt("catid"));
				cb.setCatName(rs.getString("catname"));
				cb.setCatAge(rs.getString("catage"));
				cb.setCatGender(rs.getString("catgender"));
				cb.setCatNeuter(rs.getString("catneuter"));
				cb.setCatVaccination(rs.getString("catvaccination"));
				cb.setCatIng(rs.getString("cat_ing"));
				cb.setCatInfo(rs.getString("catinfo"));
				cb.setCatDate(rs.getString("catdate"));
				cb.setFileRealName(rs.getString("fileRealName"));
				cb.setDate(rs.getTimestamp("date"));
				cb.setReadcount(rs.getInt("readcount"));

				cbList.add(cb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return cbList;
		
		}
	
	public CatsBean getCats(int catId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		CatsBean cb=new CatsBean();
		
		try {
			con=getConnection();
			
			String sql="select * from cats where catid=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, catId);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				cb.setCatId(rs.getInt("catid"));
				cb.setCatName(rs.getString("catname"));
				cb.setCatAge(rs.getString("catage"));
				cb.setCatGender(rs.getString("catgender"));
				cb.setCatNeuter(rs.getString("catneuter"));
				cb.setCatVaccination(rs.getString("catvaccination"));
				cb.setCatIng(rs.getString("cat_ing"));
				cb.setCatInfo(rs.getString("catinfo"));
				cb.setCatDate(rs.getString("catdate"));
				cb.setFileRealName(rs.getString("fileRealName"));
				cb.setDate(rs.getTimestamp("date"));
				cb.setReadcount(rs.getInt("readcount"));

			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try {rs.close();} catch (SQLException ex) {}
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}
		
		return cb;
	}

	public int getBoardCount(String search, String ing) {
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		int count=0;
		
		try {
			con=getConnection();
			
			String sql="select count(*) from cats where catname like ? and cat_ing=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%"); 
			pstmt.setString(2, ing);
			
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
	
	public List<CatsBean> getBoardList(int startRow, int pageSize, String search, String ing) {

		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<CatsBean> cbList=new ArrayList<CatsBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from cats where catname like ? and cat_ing=? order by catid desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setString(2, ing);
			pstmt.setInt(3, startRow-1);
			pstmt.setInt(4, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {

				CatsBean cb = new CatsBean();
				cb.setCatId(rs.getInt("catid"));
				cb.setCatName(rs.getString("catname"));
				cb.setCatAge(rs.getString("catage"));
				cb.setCatGender(rs.getString("catgender"));
				cb.setCatNeuter(rs.getString("catneuter"));
				cb.setCatVaccination(rs.getString("catvaccination"));
				cb.setCatIng(rs.getString("cat_ing"));
				cb.setCatInfo(rs.getString("catinfo"));
				cb.setCatDate(rs.getString("catdate"));
				cb.setFileRealName(rs.getString("fileRealName"));
				cb.setDate(rs.getTimestamp("date"));
				cb.setReadcount(rs.getInt("readcount"));

				cbList.add(cb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return cbList;
		
		
	}
	
	public void updateCats(CatsBean cb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update cats set catname=?,catage=?,catgender=?,catneuter=?,catdate=?,catvaccination=?,cat_ing=?,catinfo=?,filerealname=? where catid=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cb.getCatName());
			pstmt.setString(2, cb.getCatAge());
			pstmt.setString(3, cb.getCatGender());
			pstmt.setString(4, cb.getCatNeuter());
			pstmt.setString(5, cb.getCatDate());
			pstmt.setString(6, cb.getCatVaccination());
			pstmt.setString(7, cb.getCatIng());
			pstmt.setString(8, cb.getCatInfo());
			pstmt.setString(9, cb.getFileRealName());
			pstmt.setInt(10, cb.getCatId());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try {pstmt.close();} catch (SQLException ex) {}
			if(con!=null) try {con.close();} catch (SQLException ex) {}

		}

	}
	
	
	public void deleteCats(int catId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con = getConnection();
			
			String sql="delete from cats where catid=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, catId);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
	}
		 

}
