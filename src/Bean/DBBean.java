/**
 * 
 */
package Bean;

/**
 * @author lin
 * 用于处理与数据库的交互,关于事件记录的增删改查
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import Entity.Record;

import com.mysql.jdbc.Connection;

public class DBBean {

	private static final String DRIVER = "com.mysql.jdbc.Driver";
	private static final String ADDRESS = "jdbc:mysql://localhost/mynotebook";
	private static final String USER = "root";
	private static final String PASSWORD = "";
	Connection con = null;
	Statement stat = null;
	PreparedStatement pstat = null;
	ResultSet rs = null;

	public DBBean() {}
	
	/**
	 * 建立数据库连接
	 * @return
	 */
	public Connection getCon(){
		try{
			Class.forName(DRIVER);
		    con = (Connection) DriverManager.getConnection(ADDRESS, USER, PASSWORD);
		    if (con != null && !con.isClosed()) 
			{
				System.out.println("MySQL Connection Succeeded!");
			} 
			else 
			{
				System.err.println("MySQL Connection Failed!");
				return null;
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return con;		
	}
	
	/**
	 * 执行查询语句
	 * @param sql
	 * @return
	 */
	public ResultSet query(String sql){
		try{
			con = getCon();
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return rs;
	}
	
	/**
	 * 执行更新sql语句
	 * @param sql
	 */
	public void update(String sql){
		try{
			con = getCon();
			stat = con.createStatement();
			stat.executeUpdate(sql);
		}catch(Exception ex){
			ex.printStackTrace();
		}
	}
	
	/**
	 * 新增一条事件记录
	 * @param record
	 * @return
	 */
	public boolean insertRecord (Record record)
	{
		PreparedStatement pstmt=null;
		if(record==null)return false;
		if(record.getTitle().equals(""))return false;
		try{
			con=getCon();
			String sql = "insert into record(title,content,time) values(?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,record.getTitle());
			pstmt.setString(2,record.getContent());
			pstmt.setString(3,record.getTime());
			pstmt.executeUpdate();
			pstmt.close();
		}catch(Exception e)
		 {e.printStackTrace();}
		 finally{close();}
		return true;
	}
	
	/**
	 * 删除一条记录
	 * @param record
	 * @return
	 */
	public boolean deleteRecord (Record record)
	{
		if(!checkRecord(record)) return false;
		String sql="delete from record where id='"+record.getId()+"'";
		update(sql);
		return true;
	}
	
	/**
	 * 修改一条记录
	 * @param record
	 * @return
	 */
	public boolean changeRecord (Record record)
	{
		if(!checkRecord(record)) return false;
		String sql="update record set title='"+record.getTitle()+"', content='"+record.getContent()
				+"', time='"+record.getTime()+"' where id='"+record.getId()+"'";
		update(sql);
		return true;
	}
	
	/**
	 * 查询是否有该条记录
	 * @param record
	 * @return
	 */
	public boolean checkRecord(Record record)
	{
		con=getCon();
		if (record==null) return false;
		String sql="select * from record where id='"+record.getId()+"'";
		ResultSet rs = query(sql);
		try {
			boolean right=rs.next();
			return right;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	/**
	 * 获取记录条数
	 * @return
	 */
	public int getRecordCount(){
		int count=0;
		String sql="select count(*) from record";
		con=getCon();
		try {
			pstat = con.prepareStatement(sql);
			rs = pstat.executeQuery();
			if(rs.next()){
				count=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close();
		}
		return count;
	}
	/**
	 * 根据关键词获取记录条数
	 * @param keyword
	 * @return
	 */
	public int getRecordCount(String keyword){
		int count=0;
		String sql="select count(*) from record where title like '%"+keyword+"%' or content like '%"+
				keyword+"%'";
		con=getCon();
		try {
			pstat = con.prepareStatement(sql);
			rs = pstat.executeQuery();
			if(rs.next()){
				count=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close();
		}
		return count;
	}
	
	/**
	 *  根据页号获取一页的事件记录集合，根据id降序排序，限制为10条
	 * @param pageIndex
	 * @return
	 */
	public List<Record> getRecords(int pageIndex){
		List<Record> records= new ArrayList<Record>();
		int num=(pageIndex-1)*10;//倒数起始点
		con=getCon();
		String sql = "select * from record order by id desc limit "+num+",10";
		try{
			pstat = con.prepareStatement(sql);
			rs = pstat.executeQuery();
			while(rs.next()){
				records.add(new Record(rs.getInt("id"),
						rs.getString("title"),
						rs.getString("content"),
						rs.getString("time")
						) );
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close();
		}
		return records;
	}
	
	/**
	 * 根据页号和关键词获取一页的事件记录集合，根据id降序排序，限制为10条
	 * @param pageIndex
	 * @param keyword
	 * @return
	 */
	public List<Record> getRecords(int pageIndex,String keyword){
		List<Record> records= new ArrayList<Record>();
		int num=(pageIndex-1)*10;//倒数起始点
		con=getCon();
		String sql = "select * from record where title like '%"+keyword+"%' or content like '%"+
		keyword+"%' order by id desc limit "+num+",10";
		try{
			pstat = con.prepareStatement(sql);
			rs = pstat.executeQuery();
			while(rs.next()){
				records.add(new Record(rs.getInt("id"),
						rs.getString("title"),
						rs.getString("content"),
						rs.getString("time")
						) );
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close();
		}
		return records;
	}
	
	public void close(){
		try{
			if (rs != null)rs.close();
			if (stat != null)stat.close();
			if (pstat != null)pstat.close();
			if (con != null)con.close();
		}catch(Exception ex){
			ex.printStackTrace();
		}		
	}	
	
}
