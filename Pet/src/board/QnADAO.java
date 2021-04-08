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

public class QnADAO {
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
		
			String sql="select count(*) from qna";
		
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
		
			String sql="select count(*) from qna where subject like ?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
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
	
	public List<QnABean> getBoardList(int startRow, int pageSize) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<QnABean> qbList=new ArrayList<QnABean>();
		
		try {
			con=getConnection();
			
			String sql="select * from qna order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				QnABean qb = new QnABean();
				qb.setCode(rs.getInt("code"));
				qb.setNum(rs.getInt("num"));
				qb.setGroupNum(rs.getInt("groupnum"));
				qb.setState(rs.getString("state"));
				qb.setName(rs.getString("name"));
				qb.setSubject(rs.getString("subject"));
				qb.setContent(rs.getString("content"));
				qb.setDate(rs.getTimestamp("date"));
				qb.setReadcount(rs.getInt("readcount"));
				
				qbList.add(qb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return qbList;
		
		}
	
	public List<QnABean> getBoardList(int startRow, int pageSize, String search) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
				
		List<QnABean> qbList=new ArrayList<QnABean>();
		
		try {
			con=getConnection();
			
			String sql="select * from qna where subject like ? order by num desc limit ?,?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				QnABean qb = new QnABean();
				qb.setCode(rs.getInt("code"));
				qb.setNum(rs.getInt("num"));
				qb.setGroupNum(rs.getInt("groupnum"));
				qb.setState(rs.getString("state"));
				qb.setName(rs.getString("name"));
				qb.setSubject(rs.getString("subject"));
				qb.setContent(rs.getString("content"));
				qb.setDate(rs.getTimestamp("date"));
				qb.setReadcount(rs.getInt("readcount"));
				
				qbList.add(qb);
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
		return qbList;
		
		}
	
	public void insertBoard(QnABean qb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		PreparedStatement pstmt3=null;
		ResultSet rs=null;
		ResultSet rs2=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
		
			int num=0;
			int code=0;
			int groupNum=0;
			String state="답변대기";
			
			String sql2 = "select max(num) from qna";
			pstmt2=con.prepareStatement(sql2);
		
			rs = pstmt2.executeQuery();
		
			if(rs.next()) {
				num = rs.getInt("max(num)") + 1;
			}
			
			String sql3 = "select max(code) from qna";
			pstmt3=con.prepareStatement(sql3);
		
			rs2 = pstmt3.executeQuery();
		
			if(rs2.next()) {
				code = rs2.getInt("max(code)") + 1;
			}
				
			String sql="insert into qna(code,num,groupnum,state,name,subject,content,date,readcount) values(?,?,?,?,?,?,?,?,?)";
		
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, code);
			pstmt.setInt(2, num);
			pstmt.setInt(3, groupNum);
			pstmt.setString(4, state);
			pstmt.setString(5, qb.getName());
			pstmt.setString(6, qb.getSubject());
			pstmt.setString(7, qb.getContent());
			pstmt.setTimestamp(8, qb.getDate());
			pstmt.setInt(9, qb.getReadcount());
		
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null)  try { pstmt.close(); } catch (SQLException ex) { } 
			if(rs2!=null)  try { rs2.close(); } catch (SQLException ex) { }
			if(pstmt3!=null)  try { pstmt3.close(); } catch (SQLException ex) { } 
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt2!=null)  try { pstmt2.close(); } catch (SQLException ex) { } 
			if(con!=null)  try { con.close(); } catch (SQLException ex) { } 
	}
	
}
	
	public void updateReadcount(int code) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="update qna set readcount=readcount+1 where code=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, code);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
	}
	
	public QnABean getBoard(int code) {
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		QnABean qb = new QnABean();
		
		try {
			con=getConnection();
			
			String sql="select * from qna where code=?";
		
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, code);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				qb.setCode(rs.getInt("code"));
				qb.setNum(rs.getInt("num"));
				qb.setGroupNum(rs.getInt("groupnum"));
				qb.setState(rs.getString("state"));
				qb.setName(rs.getString("name"));
				qb.setSubject(rs.getString("subject"));
				qb.setContent(rs.getString("content"));
				qb.setDate(rs.getTimestamp("date"));
				qb.setReadcount(rs.getInt("readcount"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
		return qb;
		
	}
	
	public void insertAnswer(QnABean qb) {
		Connection con=null;
		PreparedStatement pstmt2=null;
		PreparedStatement pstmt3=null;
		ResultSet rs=null;
		ResultSet rs2=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
		
			int code=0;
			int groupNum=0;
			
			String sql2 = "select max(groupnum) from qna";
			pstmt2=con.prepareStatement(sql2);
		
			rs = pstmt2.executeQuery();
		
			if(rs.next()) {
				groupNum = rs.getInt("max(groupnum)") + 1;
			}
			
			String sql3 = "select max(code) from qna";
			pstmt3=con.prepareStatement(sql3);
		
			rs2 = pstmt3.executeQuery();
		
			if(rs2.next()) {
				code = rs2.getInt("max(code)") + 1;
			}
				
			String sql="insert into qna values(?,?,?,?,?,?,?,?,?)";
		
			pstmt=con.prepareStatement(sql);
			
			pstmt.setInt(1, code);
			pstmt.setInt(2, qb.getNum());
			pstmt.setInt(3, groupNum);
			pstmt.setString(4, qb.getState());
			pstmt.setString(5, qb.getName());
			pstmt.setString(6, "[RE : ]"+qb.getSubject());
			pstmt.setString(7, qb.getContent());
			pstmt.setTimestamp(8, qb.getDate());
			pstmt.setInt(9, qb.getReadcount());
		
			pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null)  try { pstmt.close(); } catch (SQLException ex) { } 
			if(rs2!=null)  try { rs2.close(); } catch (SQLException ex) { }
			if(pstmt3!=null)  try { pstmt3.close(); } catch (SQLException ex) { } 
			if(rs!=null) try { rs.close(); } catch (SQLException ex) { } 
			if(pstmt2!=null)  try { pstmt2.close(); } catch (SQLException ex) { } 
			if(con!=null)  try { con.close(); } catch (SQLException ex) { } 
	}
	
}
	
	public void updateState(int code) {
		Connection con=null;
		PreparedStatement pstmt=null;
		
		try {
			con=getConnection();
			
			String sql="update qna set state=? where code=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "답변완료");
			pstmt.setInt(2, code);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
	}
	
	public void updateBoard(QnABean qb) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con=getConnection();
			
			String sql="update qna set subject=?, content=? where code=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, qb.getSubject());
			pstmt.setString(2, qb.getContent());
			pstmt.setInt(3, qb.getCode());
			
			pstmt.executeUpdate();
			
					
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
		}
		
	}
	
	public void deleteBoard(int code) {
		Connection con=null;
		PreparedStatement pstmt=null;
		try {
			con = getConnection();
			
			String sql="delete from qna where code=?";
			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, code);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(pstmt!=null) try { pstmt.close(); } catch (SQLException ex) { } 
			if(con!=null) try { con.close(); } catch (SQLException ex) { } 
			
		}
		
	}
	
}
