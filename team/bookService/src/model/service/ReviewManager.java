package model.service;

import java.sql.SQLException;
import java.util.List;

import model.review;
import model.dao.ReviewDAO;

public class ReviewManager {
	private static ReviewManager rwMan = new ReviewManager();
	private ReviewDAO reviewDAO;

	private ReviewManager() {
		try {
			reviewDAO = new ReviewDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static ReviewManager getInstance() {
		return rwMan;
	}
	
	public int create(review review) throws SQLException, ExistingUserException {
		return reviewDAO.addReview(review);
	}
	
	
	public List<review> getReviewList(String bookInfoID) throws SQLException {
		return reviewDAO.getReviewList(bookInfoID);
	}

	public ReviewDAO getReviewDAO() {
		return this.reviewDAO;
	}

}
