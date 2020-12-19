package model;
import java.util.Date;
public class review {
	private String reviewContent;
	private int preference;
	private Date reviewDate;
	private String memberID;
	private int reviewID;
	private String bookInfoID;

	public review() {
		super();
	}
	
	public review(String reviewContent, int preference, Date reviewDate, String memberID, int reviewID, String bookInfoID) {
		super();
		
		this.reviewContent = reviewContent;
		this.preference = preference;
		this.reviewDate = reviewDate;
		this.memberID = memberID;
		this.reviewID = reviewID;
		this.bookInfoID = bookInfoID;
	}
	
	public review(String reviewContent, int preference, Date reviewDate, String memberID, String bookInfoID) {
		super();
		
		this.reviewContent = reviewContent;
		this.preference = preference;
		this.reviewDate = reviewDate;
		this.memberID = memberID;
		this.reviewID = -1;
		this.bookInfoID = bookInfoID;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public int getPreference() {
		return preference;
	}

	public void setPreference(int preference) {
		this.preference = preference;
	}

	public Date getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}

	public String getMemberID() {
		return memberID;
	}

	public void setMemberID(String memberID) {
		this.memberID = memberID;
	}

	public int getReviewID() {
		return reviewID;
	}

	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}

	public String getBookInfoID() {
		return bookInfoID;
	}

	public void setBookInfoID(String bookInfoID) {
		this.bookInfoID = bookInfoID;
	}
	
}
