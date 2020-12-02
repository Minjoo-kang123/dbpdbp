package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import model.*;
import model.dao.BookInfoDao;
import model.service.MemberNotFoundException;
import model.service.memberManager;

public class rentalbookDAO {
	private JDBCUtil jdbcUtil = null;
	
	public rentalbookDAO() {			
		jdbcUtil = new JDBCUtil();	// JDBCUtil 객체 생성
	}
	
	
	/*rentalBook 자체의 DAO _ retalBook insert, update, remove*/
	public int insert(rentalBook book) throws SQLException { 
		String sql = "Insert into rentalbook(bookID, memberID, bookInfoId, image, explain, point, condition, state)" + 
		 		"values(seq_bookID.NEXTVAL,?,?,?,?,?,?,?)";      
	      
		Object[] param = new Object[] {book.getSellerID(), book.getBookInfoID(),book.getImage(), 
	                       book.getExplain(), book.getPoint(), book.getCondition(), book.getState()};            
	       
		 jdbcUtil.setSqlAndParameters(sql, param);
	 
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
	   
	   public int update(rentalBook book) throws SQLException {
	      String sql = "UPDATE rentalBook "
	               + "SET memberID = ?, bookInfoId = ?, image = ?, explain = ?, point = ?, condition = ? "
	               + "WHERE bookID = ?";
	      Object[] param = new Object[] {book.getSellerID(), book.getBookInfoID(), 
	            book.getImage(), book.getExplain(), book.getPoint(), book.getCondition(), book.getBookID()};   
	      jdbcUtil.setSqlAndParameters(sql, param);   // JDBCUtil에 update문과 매개 변수 설정
	         
	      try {            
	         int result = jdbcUtil.executeUpdate();   // update 문 실행
	         return result;
	      } catch (Exception ex) {
	         jdbcUtil.rollback();
	         ex.printStackTrace();
	      }
	      finally {
	         jdbcUtil.commit();
	         jdbcUtil.close();   // resource 반환
	      }      
	      return 0;
	   }

	   public int remove(int bookID) throws SQLException {
		   
         String sql = "DELETE FROM RENTALBOOK WHERE bookID = ?";      
         jdbcUtil.setSqlAndParameters(sql, new Object[] {bookID});   // JDBCUtil에 delete문과 매개 변수 설정
         
	      try {            
	         int result = jdbcUtil.executeUpdate();   // delete 문 실행
	         return result;
	      } catch (Exception ex) {
	         jdbcUtil.rollback();
	         ex.printStackTrace();
	      }
	      finally {
	         jdbcUtil.commit();
	         jdbcUtil.close();   // resource 반환
	      }      
	      return 0;
	   }
	   
	   /* rentalBook을 이용 함수_ 책  대여하기랑 반납하기용 (retalInfo insert랑 rentalBook _ state update 등.*/

	   //rentalBook에 있는 정보를 bookID로 찾아서 객체 상태로 반환.
		public rentalBook findRentBook(int bookID) throws SQLException{
			String query = "select r.memberID, r.bookInfoID, image, explain, state, point, condition, bookname "
					+	"from rentalBook r join bookinfo b on r.bookinfoid = b.bookinfoid where bookID = ?";
			
			jdbcUtil.setSqlAndParameters(query, new Object[] {bookID});
			
			try {
				ResultSet rs = jdbcUtil.executeQuery();		// query 실행
				if (rs.next()) {						
					rentalBook rtbook = new rentalBook (		
						bookID,
						rs.getString("memberID"),
						rs.getString("bookinfoID"),
						rs.getString("image"),
						rs.getString("explain"),
						rs.getInt("state"),					
						rs.getInt("point"),
						rs.getInt("condition"),
						rs.getString("bookname"));
					return rtbook;
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				jdbcUtil.close();		// resource 반환
			}
			
			return null;
		}
		
		public List<rentalBook> findRentBookList(String bookInfoID) throws SQLException{
			String query = "select  r.bookID, r.memberID, r.bookInfoID, r.image, r.explain, r.state, r.point, r.condition, i.bookname  "
					+	"from rentalBook r, bookInfo i where r.bookInfoID = i.bookInfoID and r.bookInfoID = ?";
			jdbcUtil.setSqlAndParameters(query, new Object[] {bookInfoID});
			
			System.out.println(query);
			try {
				ResultSet rs = jdbcUtil.executeQuery();		// query 실행
				List<rentalBook> mRentalBookList = new ArrayList<rentalBook>();
				
				while(rs.next()) {
					rentalBook rtbook = new rentalBook (		
							rs.getInt("bookID"),
							rs.getString("memberID"),
							rs.getString("bookinfoID"),
							rs.getString("image"),
							rs.getString("explain"),
							rs.getInt("state"),					
							rs.getInt("point"),
							rs.getInt("condition"),
							rs.getString("bookname"));

					mRentalBookList.add(rtbook);
				   }
				   
				   return mRentalBookList;
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				jdbcUtil.close();		// resource 반환
			}
			
			return null;
		}
		
		
		//rentBook 반납하기. : rentalBook의 상태를 false로 바꿈. + 여기에  rentalInfo도 상태 바꿔주는 작업 필요.
		public int returnBook(rentalInfo rInfo) throws SQLException {
			
			String query1 = "Update rentalBook set state = 0 where bookID = ?";
			Object[] param1 = new Object[] { rInfo.getBookID() };
			
			String query2 = "Update rentalInfo set state = 0 where rentalID = ?";
			Object[] param2 = new Object[] { rInfo.getRentalID() };
			
			try {	
				jdbcUtil.setSqlAndParameters(query1, param1);
				int result1 = jdbcUtil.executeUpdate();	
				if(result1 != 1) {
					throw new Exception();
				}
				
				jdbcUtil.setSqlAndParameters(query2, param2);
				int result2 = jdbcUtil.executeUpdate();	
				if(result2 != 1) {
					throw new Exception();
				}
				
				return 1;
			} catch (Exception ex) {
				jdbcUtil.rollback();
				ex.printStackTrace();
			} finally {		
				jdbcUtil.commit();
				jdbcUtil.close();	// resource 반환
			}		
			return 0;
		}


		public rentalInfo findRentInfo(int rentalID) {
			
			String query = "select i.bookid as bookid, sellerid, rentalerid, rentalDate, returnDate, bookname, r.point as point, i.state as state " + 
	          		"from rentalBook r inner join bookinfo b on b.bookinfoID = r.bookinfoID " + 
	          		"inner join rentalInfo i on i.bookid = r.bookid " +
	          		"where i.rentalid = ? ";
			jdbcUtil.setSqlAndParameters(query, new Object[] {rentalID});
			
			try {
				ResultSet rs = jdbcUtil.executeQuery();		// query 실행
				if (rs.next()) {						
					rentalInfo rInfo = new rentalInfo (	
						rentalID,
						rs.getInt("bookid"),
						rs.getString("sellerid"),
						rs.getString("rentalerid"),
						rs.getDate("rentalDate"),
						rs.getDate("returnDate"),
						rs.getString("bookname"),
						rs.getInt("point"),
						rs.getInt("state")
					);
					return rInfo;
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				jdbcUtil.close();		// resource 반환
			}
			
			return null;
		}
		
		public rentalInfo findRentInfo(int bookID, int state) {
			
			String query = "select rentalid, sellerid, rentalerid, rentalDate, returnDate, bookname, r.point as point " + 
	          		"from rentalBook r inner join bookinfo b on b.bookinfoID = r.bookinfoID " + 
	          		"inner join rentalInfo i on i.bookid = r.bookid " +
	          		"where i.bookid = ? and i.state = ?";
			jdbcUtil.setSqlAndParameters(query, new Object[] {bookID, state});
			
			try {
				ResultSet rs = jdbcUtil.executeQuery();		// query 실행
				if (rs.next()) {						
					rentalInfo rInfo = new rentalInfo (	
						rs.getInt("rentalid"),
						bookID,
						rs.getString("sellerid"),
						rs.getString("rentalerid"),
						rs.getDate("rentalDate"),
						rs.getDate("returnDate"),
						rs.getString("bookname"),
						rs.getInt("point"),
						state
					);
					return rInfo;
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				jdbcUtil.close();		// resource 반환
			}
			
			return null;
		}



		public boolean existingBookInfo(String bookInfoID) {
			String sql = "SELECT count(*) FROM bookinfo WHERE bookinfoid=?";      
			jdbcUtil.setSqlAndParameters(sql, new Object[] {bookInfoID});	// JDBCUtil에 query문과 매개 변수 설정

			try {
				ResultSet rs = jdbcUtil.executeQuery();		// query 실행
				if (rs.next()) {
					int count = rs.getInt(1);
					return (count == 1 ? true : false);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				jdbcUtil.close();		// resource 반환
			}
			return false;
		}


		//rentalBook 대여하기 기능 
		public int rental(int rBookID, String sellerID, String rentalerID) throws SQLException, MemberNotFoundException {
			
			//해당 대여 도서의 객체를 가져옴.
			rentalBook rtBook = findRentBook(rBookID);
			
			//해당 대여 도서의 도서 정보(bookInfo)에서 해당 책의 대여 횟수 증가 ( 이후 인기순 정렬 등에 사용 예정)
			String query1 = "Update bookInfo set rentalCnt = rentalCnt + 1 where bookinfoID = ?";
			Object[] param1 = new Object[] { rtBook.getBookInfoID() };
			
			//해당 대여 도서의 상태를 대여 중임을 의미하는  1로 update
			String query2 = "Update rentalBook set state = 1 where bookID = ?";
			Object[] param2 = new Object[] { rBookID };
			
			//대여자의 보유 포인트 값에서 대여도서의 포인트 값 만큼을 빼줌.
			String query3 = "Update Member set point = point - ? where MEMBERID = ?";
			Object[] param3 = new Object[] { rtBook.getPoint(), rentalerID };
			
			//판매자의 보유 포인트 값에 대여도서의 포인트 값 만큼을 더해줌.
			String query4 = "Update Member set point = point + ? where MEMBERID = ?";
			Object[] param4 = new Object[] { rtBook.getPoint(), sellerID };
			
			//rentalInfo 테이블에  해당 대여 도서에 대한 기록(관계)을 insert 해줌. (대여번호, 대여일, 반납일, 판매자, 대여자 등 )
			String query5 = "Insert into rentalInfo values(seq_rentalID.NEXTVAL, sysdate, sysdate + 14, ?, ?, ?, 1)";
			Object[] param5 = new Object[] { sellerID, rentalerID, rBookID };
			
			//위의 쿼리들을 차례로 실행. 예외사항 발생 시 catch 문에서 rollback 해줌.
			try {	
				jdbcUtil.setSqlAndParameters(query1, param1);
				int result1 = jdbcUtil.executeUpdate();	
				if(result1 != 1) {
					throw new Exception();
				}
				
				jdbcUtil.setSqlAndParameters(query2, param2);
				int result2 = jdbcUtil.executeUpdate();	
				if(result2 != 1) {
					throw new Exception();
				}
				
				jdbcUtil.setSqlAndParameters(query3, param3);
				int result3 = jdbcUtil.executeUpdate();	
				if(result3 != 1) {
					throw new Exception();
				}
				
				jdbcUtil.setSqlAndParameters(query4, param4);
				int result4 = jdbcUtil.executeUpdate();	
				if(result4 != 1) {
					throw new Exception();
				}
				
				jdbcUtil.setSqlAndParameters(query5, param5);
				int result5 = jdbcUtil.executeUpdate();	
				if(result5 != 1) {
					throw new Exception();
				}
				return 1;
			} catch (Exception ex) {
				jdbcUtil.rollback();
				ex.printStackTrace();
			} finally {		
				jdbcUtil.commit();
				jdbcUtil.close();	// resource 반환
			}		
			return 0;
			
		}

		
}
