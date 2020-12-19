package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.review;

public class ReviewDAO {
	
	private JDBCUtil jdbcUtil = null;

	   
	   public ReviewDAO() {         
	      jdbcUtil = new JDBCUtil();   // JDBCUtil 객체 생성
	   }
	   
	   public int addReview(review review) throws SQLException{
	      String query = "Insert into review(reviewContent, reviewDate, memberID, reviewID, bookInfoID) values(?,?,?,?,?)";
	      Object[] param = new Object[] {review.getReviewContent(),  review.getReviewDate(), review.getMemberID(), review.getReviewID(), review.getBookInfoID()};
	      jdbcUtil.setSqlAndParameters(query, param);
	      System.out.println(query + param);
	      
	      try {
	         int result = jdbcUtil.executeUpdate();
	         return result;
	      } catch (Exception ex) {
	         jdbcUtil.rollback();
	         ex.printStackTrace();
	      } finally {      
	         jdbcUtil.commit();
	         jdbcUtil.close();   // resource 반환
	      }      
	      return 0;
	   }	   
	   
	   //bookInfoID로 검색하기!
	   public List<review> getReviewList(String bookInfoID) throws SQLException {
		   String query = "select reviewContent, reviewDate, memberID, reviewID, bookInfoID "
	               + "from review "
				   + "where bookInfoID = ? ";
		   jdbcUtil.setSqlAndParameters(query, new Object[] {bookInfoID});
		   
		   try {
			   ResultSet rs = jdbcUtil.executeQuery();
			   List<review> mReviewList = new ArrayList<review>();
			   
			   while(rs.next()) {
				   review review = new review();
				   
				   System.out.println(rs.getString("memberID"));
				   review.setReviewContent(rs.getString("reviewContent"));
				   review.setReviewDate(rs.getDate("reviewDate"));
				   review.setMemberID(rs.getString("memberID"));
				   review.setReviewID(rs.getInt("reviewID"));
				   review.setBookInfoID(rs.getString("bookInfoID"));
				   
				   mReviewList.add(review);
			   }
			   
			   return mReviewList;
		   	}catch(Exception ex) {}
	       
	       return null;
	   }

}
