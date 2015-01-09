package cn.fengpu.ext;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import cn.fengpu.model.User;
/**
 * @author Lucare
 * 带分页的查询列表
 * 2015年1月7日
 */
public class UserServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Connection con;
	private List<User> users;
	private int count;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			String start = request.getParameter("start");
			String limit = request.getParameter("limit");
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ext","root","root");
			users = findAll(start, limit);
			count = totalCount();
			Gson gson = new Gson();
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print("{total:"+count+",root:"+gson.toJson(users)+"}");
			System.out.println("{total:"+count+",root:"+gson.toJson(users)+"}");
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeCon();
		}
	}
	
	public List<User> findAll(String start,String limit){
		List<User> userlist = new ArrayList<User>();
		try {
			PreparedStatement ps = con.prepareStatement("select * from users limit "+start+","+limit);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				User user = new User();
				user.setName(rs.getString(1));
				user.setAge(rs.getInt(2));
				user.setPhone(rs.getString(3));
				userlist.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userlist;
	}
	
	public int totalCount(){
		int total = 0;
		try {
			PreparedStatement ps = con.prepareStatement("select count(*) from users");
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return total;
	}
	
	public void closeCon(){
		if(con!=null){
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
