package model;
import java.util.Date;
public class rentalInfo {
	private int rentalID;
	private int bookID;
	private String sellerID;
	private String rentalerID;
	private Date rentalDate;
	private Date returnDate;
	private String bookname;
	private int point;
	private int state;
	
	public rentalInfo() {
		super();
	}
	public rentalInfo(int rentalID, int bookID, String sellerID, String rentalerID, Date rentalDate, Date returnDate,
			String bookname, int point, int state) {
		super();
		this.rentalID = rentalID;
		this.bookID = bookID;
		this.sellerID = sellerID;
		this.rentalerID = rentalerID;
		this.rentalDate = rentalDate;
		this.returnDate = returnDate;
		this.bookname = bookname;
		this.point = point;
		this.state = state;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	public int getRentalID() {
		return rentalID;
	}
	public void setRentalID(int rentalID) {
		this.rentalID = rentalID;
	}
	public int getBookID() {
		return bookID;
	}
	public void setBookID(int bookID) {
		this.bookID = bookID;
	}
	public String getSellerID() {
		return sellerID;
	}
	public void setSellerID(String sellerID) {
		this.sellerID = sellerID;
	}
	public String getRentalerID() {
		return rentalerID;
	}
	public void setRentalerID(String rentalerID) {
		this.rentalerID = rentalerID;
	}
	public Date getRentalDate() {
		return rentalDate;
	}
	public void setRentalDate(Date rentalDate) {
		this.rentalDate = rentalDate;
	}
	public Date getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	
	
}
	
