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

public class ReplyDAO {
	public Connection getConnection() throws Exception {

		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");	
		Connection con=ds.getConnection();
		return con;
	}
	
	public void insertReply(ReplyBean rb) {
		Connection con=null;
		ResultSet rs=null;
		ResultSet rs2=null;

		PreparedStatement pstmt2=null;
		PreparedStatement pstmt=null;
		PreparedStatement pstmt3=null;

		try {
			con=getConnection();
			
			int num=0;
			int re_ref=0;

			String sql2 = "select max(num) from reply";
			pstmt2=con.prepareStatement(sql2);
			
			rs = pstmt2.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
				
			String sql3 = "select max(re_ref) from reply where boardnum=?";
			pstmt3=con.prepareStatement(sql3);
			pstmt3.setInt(1, rb.getBoardNum());
			
			rs2 = pstmt3.executeQuery();
			
			if(rs2.next()) {
				re_ref = rs2.getInt("max(re_ref)") + 1;
			}
			
			String sql="insert into reply(num,boardnum,re_ref,re_lev,re_seq,name,content,date) values(?,?,?,?,?,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, rb.getBoardNum());
			pstmt.setInt(3, re_ref);
			pstmt.setInt(4, 0); 
			pstmt.setInt(5, 0); 
			pstmt.setString(6, rb.getName());
			pstmt.setString(7, rb.getContent());
			pstmt.setTimestamp(8, rb.getDate());

			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null)  try { pstmt.close(); } catch (SQLException ex) { } 
			if(rs2!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt3!=null)  try { pstmt2.close(); } catch (SQLException ex) { } 
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt2!=null)  try { pstmt2.close(); } catch (SQLException ex) { } 
			if(con!=null)  try { con.close(); } catch (SQLException ex) { } 
		}
		
	}
	
	public List<ReplyBean> getReplyList(int startRow, int pageSize, int boardNum) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<ReplyBean> rbList=new ArrayList<ReplyBean>();
		
		try {
			con=getConnection();
			
			String sql="select * from reply where boardnum=? order by re_ref, re_seq asc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReplyBean rb = new ReplyBean();
				rb.setNum(rs.getInt("num"));
				rb.setBoardNum(rs.getInt("boardnum"));
				rb.setRe_ref(rs.getInt("re_ref"));
				rb.setRe_lev(rs.getInt("re_lev"));
				rb.setRe_seq(rs.getInt("re_seq"));
				rb.setName(rs.getString("name"));
				rb.setContent(rs.getString("content"));
				rb.setDate(rs.getTimestamp("date"));
				rb.setDeleteAt(rs.getTimestamp("delete_at"));
				
				rbList.add(rb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return rbList;
		
	}
	
	public int getReplyCount(int boardNum) {
		int count=0;
		
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="select count(*) from reply where boardNum=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

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
	
	public int getReplyCount2(int boardNum) {
		int count=0;
		
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="select count(*) from reply where boardNum=? and delete_at is null";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, boardNum);

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
	
	public void reinsertReply(ReplyBean rb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			int num=0;

			String sql2 = "select max(num) from reply";
			pstmt2=con.prepareStatement(sql2);
			
			rs = pstmt2.executeQuery();
			
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			
			
			sql2="update reply set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt2=con.prepareStatement(sql2);
			pstmt2.setInt(1, rb.getRe_ref());
			pstmt2.setInt(2, rb.getRe_seq());
			pstmt2.executeUpdate();
					
			String sql="insert into reply(num,boardnum,re_ref,re_lev,re_seq,name,content,date) values(?,?,?,?,?,?,?,?)";
			
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			pstmt.setInt(2, rb.getBoardNum());
			pstmt.setInt(3, rb.getRe_ref());
			pstmt.setInt(4, rb.getRe_lev()+1); 
			pstmt.setInt(5, rb.getRe_seq()+1); 
			pstmt.setString(6, rb.getName());
			pstmt.setString(7, rb.getContent());
			pstmt.setTimestamp(8, rb.getDate());

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
	
	public void updateReply(ReplyBean rb) {
		Connection con=null;
		PreparedStatement pstmt=null;

		try {
			con=getConnection();
			
			String sql="update reply set content=? where num=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, rb.getContent());
			pstmt.setInt(2, rb.getNum());
			
			pstmt.executeUpdate();
			
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
	}
	
	public void deleteReply(ReplyBean rb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		
		try {
			con = getConnection();
	
			String sql="delete from reply where num=?";
			pstmt=con.prepareStatement(sql);
				
			pstmt.setInt(1, rb.getNum());
				
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
	}
	
}
