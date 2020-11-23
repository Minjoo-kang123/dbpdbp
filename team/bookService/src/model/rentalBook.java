package model;

public class rentalBook {
	
	private int bookID;
	private String sellerID;
	private String bookInfoID;
	private String image;
	private String explain;
	private int state;
	private int point;
	private int condition;
	private String bookname;
	
	public rentalBook(int bookID, String sellerID, String bookInfoID, String image, String explain,
			int state, int point, int condition, String bookname) {
		super();
		this.bookID = bookID;
		this.sellerID = sellerID;
		this.bookInfoID = bookInfoID;
		this.image = image;
		this.explain = explain;
		this.state = state;
		this.point = point;
		this.condition = condition;
		this.bookname = bookname;
	}
	
	public rentalBook() {
		super();
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
	public String getBookInfoID() {
		return bookInfoID;
	}
	public void setBookInfoID(String bookInfoID) {
		this.bookInfoID = bookInfoID;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	
	public String getBookname() {
		return bookname;
	}
	public void setBookname(String bookname) {
		this.bookname = bookname;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getCondition() {
		return condition;
	}

	public void setCondition(int condition) {
		this.condition = condition;
	}
}