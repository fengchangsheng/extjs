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

import cn.fengpu.model.Cata;
import cn.fengpu.model.User;

import com.google.gson.Gson;

/**
 * Servlet implementation class GridsServlet
 */
public class GridsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Connection con;
	private List<Cata> catas;
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
			catas = findAll(start, limit);
			count = totalCount();
			Gson gson = new Gson();
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print("{total:"+count+",rows:"+gson.toJson(catas)+"}");
			System.out.println("{total:"+count+",root:"+gson.toJson(catas)+"}");
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeCon();
		}
	}
	
	public List<Cata> findAll(String start,String limit){
		List<Cata> catalist = new ArrayList<Cata>();
		try {
			PreparedStatement ps = con.prepareStatement("select * from cata limit "+start+","+limit);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Cata cata = new Cata();
				cata.setCataId(rs.getInt(1));
				cata.setCataNo(rs.getString(2));
				cata.setCataRemark(rs.getString(3));
				cata.setCataTitle(rs.getString(4));
				cata.setCataObjectName(rs.getString(5));
				cata.setCataeditstatusName(rs.getString(6));
				cata.setCataPublishName(rs.getString(7));
				cata.setCataEndDate(rs.getString(8));
				cata.setHolyUpdateTime(rs.getString(9));
				cata.setCatapushtime(rs.getString(9));
				catalist.add(cata);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return catalist;
	}
	
	public int totalCount(){
		int total = 0;
		try {
			PreparedStatement ps = con.prepareStatement("select count(*) from cata");
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
