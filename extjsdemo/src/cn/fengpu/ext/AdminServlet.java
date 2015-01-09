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

import cn.fengpu.model.Admin;
import cn.fengpu.model.User;

import com.google.gson.Gson;
import com.google.gson.JsonArray;

/**
 * @author Lucare(fcs)
 *
 * 2015年1月9日
 */
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Connection con;
	private List<Admin> admins;
	private int count;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			//根据参数param分发请求
			String param = request.getParameter("param");
			System.out.println(param);
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ext","root","root");
			Gson gson = new Gson();
			response.setCharacterEncoding("UTF-8");
			if(param.equals("read")){
				String start = request.getParameter("start");
				String limit = request.getParameter("limit");
				admins = findAll(start, limit);
				count = totalCount();
				response.getWriter().print("{total:"+count+",data:"+gson.toJson(admins)+"}");
			}else if(param.equals("add")){
				//extjs 以流的形式传递数据（json类型）
				String msg = request.getReader().readLine();
				Admin admin = gson.fromJson(msg, Admin.class);
				add(admin);
			}else if(param.equals("update")){
				String msg = request.getReader().readLine();
				Admin admin = gson.fromJson(msg, Admin.class);
				update(admin);
			}else if(param.equals("deletes")){
				String msg = request.getReader().readLine();
				Admin admin = gson.fromJson(msg, Admin.class);
				del(admin);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeCon();
		}
	}
	
	public List<Admin> findAll(String start,String limit){
		List<Admin> adminlist = new ArrayList<Admin>();
		try {
			PreparedStatement ps = con.prepareStatement("select * from admins limit "+start+","+limit);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Admin admin = new Admin();
				admin.setId(rs.getInt(1));
				admin.setEmail(rs.getString(2));;
				admin.setFirst(rs.getString(3));
				admin.setLast(rs.getString(4));
				adminlist.add(admin);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return adminlist;
	}
	
	public void add(Admin admin){
		try {
			PreparedStatement ps = con.prepareStatement("insert into admins values(null,?,?,?)");
			ps.setString(1, admin.getEmail());
			ps.setString(2, admin.getFirst());
			ps.setString(3, admin.getLast());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void del(Admin admin){
		try {
			PreparedStatement ps = con.prepareStatement("delete from admins where id=?");
			ps.setInt(1, admin.getId());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void update(Admin admin){
		try {
			PreparedStatement ps = con.prepareStatement("update admins set email=?,first=?,last=? where id=?");
			ps.setString(1,admin.getEmail());
			ps.setString(2,admin.getFirst());
			ps.setString(3,admin.getLast());
			ps.setInt(4, admin.getId());
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	public int totalCount(){
		int total = 0;
		try {
			PreparedStatement ps = con.prepareStatement("select count(*) from admins");
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
