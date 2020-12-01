package model;
import java.util.Date;

public class bookInfo {
   private String bookinfoID;
   private String bookname; //일단 id,pw int로 해두지만 string으로 바꿀 예정.
   private String writer;
   private String publisher;
   private String category;
   private String bookimage;
   private int rentalCnt;
   private Date releaseDate;
   private String summary;
   
   public bookInfo() {
      super();
   }
   
   public bookInfo(String bookinfoID, String bookname, String writer, String publisher, String category, String bookimage, int rentalCnt, Date releaseDate, String summary) {
      super();
      this.bookinfoID = bookinfoID;
      this.bookname = bookname;
      this.writer = writer;
      this.publisher = publisher;
      this.category = category;
      this.bookimage = bookimage;
      this.rentalCnt = rentalCnt;
      this.releaseDate = releaseDate;
      this.summary = summary;
   }
   
   public String getBookinfoID() {
      return bookinfoID;
   }
   public void setBookinfoID(String bookinfoID) {
      this.bookinfoID = bookinfoID;
   }
   public String getBookname() {
      return bookname;
   }
   public void setBookname(String bookname) {
      this.bookname = bookname;
   }
   public String getWriter() {
      return writer;
   }
   public void setWriter(String writer) {
      this.writer = writer;
   }
   public String getPublisher() {
      return publisher;
   }
   public void setPublisher(String publisher) {
      this.publisher = publisher;
   }
   public String getCategory() {
      return category;
   }
   public void setCategory(String category) {
      this.category = category;
   }
   public String getBookimage() {
      return bookimage;
   }
   public void setBookimage(String bookimage) {
      this.bookimage = bookimage;
   }
   public int getRentalCnt() {
      return rentalCnt;
   }
   public void setRentalCnt(int rentalCnt) {
      this.rentalCnt = rentalCnt;
   }
   public Date getReleaseDate() {
	   return releaseDate;
   }
   public void setReleaseDate(Date relaseDate) {
	   this.releaseDate = relaseDate;
   }
   public String getSummary() {
	   return summary;
   }
   public void setSummary(String summary) {
	   this.summary = summary;
   }

   public String toString() {
      return "User [bookinfoID=" + bookinfoID + ", bookname=" + bookname + ", writer=" + writer + ", publisher=" + publisher + ", category="
            + category + ", bookimage=" + bookimage + ", releasedate=" + releaseDate + ", summary=" + summary + "]";
   }   
}