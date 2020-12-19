package model;
import java.util.Date;
public class review {
	private String reviewContent;
	private int prefernce;
	private Date reviewDate;
	private String memberID;
	private int reviewID;
	private String bookInfoID;

	public review() {
		super();
	}
	
	public review(String reviewContent, int prefernce, Date reviewDate, String memberID, int reviewID, String bookInfoID) {
		super();
		
		this.reviewContent = reviewContent;
		this.prefernce = prefernce;
		this.reviewDate = reviewDate;
		this.memberID = memberID;
		this.reviewID = reviewID;
		this.bookInfoID = bookInfoID;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public int getPrefernce() {
		return prefernce;
	}

	public void setPrefernce(int prefernce) {
		this.prefernce = prefernce;
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
