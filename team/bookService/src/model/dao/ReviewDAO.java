package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import model.review;

public class ReviewDAO {
	
	private JDBCUtil jdbcUtil = null;

	   
	   public ReviewDAO() {         
	      jdbcUtil = new JDBCUtil();   // JDBCUtil 객체 생성
	   }
	   
	   public int addReview(review review) throws SQLException{
	      String query = "Insert into review(reviewContent, preference, reviewDate, memberID, reviewID, bookInfoID) values(?,?,?,?,seq_reviewID.nextval,?)";
	      String sql2 = "Update member set point = point + 50 where memberid = ?";
	      
	      SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
	      String reviewDate = format.format(review.getReviewDate());
	      
	      Object[] param = new Object[] {review.getReviewContent(),  review.getPreference(), reviewDate, review.getMemberID(), review.getBookInfoID()};
	      jdbcUtil.setSqlAndParameters(sql2, new Object[] {review.getMemberID()});
	      jdbcUtil.setSqlAndParameters(query, param);
	      
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
		   String query = "select reviewContent, preference, reviewDate, memberID, reviewID, bookInfoID "
	               + "from review "
				   + "where bookInfoID = ? ";
		   jdbcUtil.setSqlAndParameters(query, new Object[] {bookInfoID});
		   
		   try {
			   ResultSet rs = jdbcUtil.executeQuery();
			   List<review> mReviewList = new ArrayList<review>();
			   
			   while(rs.next()) {
				   review review = new review();
				   
				   review.setReviewContent(rs.getString("reviewContent"));
				   review.setPreference(rs.getInt("preference"));
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
