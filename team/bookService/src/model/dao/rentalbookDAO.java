package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import model.*;
import model.dao.BookInfoDao;

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
		
		//대여 정보가 들어있는 RentalInfo에 새로운 대여정보를 삽입.
		public int insertRentalInfo(int bookID, String memberID) throws SQLException{
			rentalBook rtBook = findRentBook(bookID);
			
			Calendar rentalD = Calendar.getInstance();
			rentalD.setTime(new Date());
			
			Calendar returnD = Calendar.getInstance();
			returnD.setTime(new Date());
			returnD.add(Calendar.DATE, 14);
			
			//rentalInfo insert
			String query1 = "Insert into rentalInfo values(seq_rentalID.NEXTVAL, ?, ?, ?, ?, ?, 1)";
			Object[] param1 = new Object[] { rentalD, returnD, rtBook.getSellerID(), memberID, bookID };
			
			try {	
				jdbcUtil.setSqlAndParameters(query1, param1);
				int result = jdbcUtil.executeUpdate();	
				return result;
			} catch (Exception ex) {
				jdbcUtil.rollback();
				ex.printStackTrace();
			} finally {		
				jdbcUtil.commit();
				jdbcUtil.close();	// resource 반환
			}		
			return 0;
			
		}
		
		// RentalBook의 대여상태를 true로 update
		public int updateRentalBook_state(int bookID) throws SQLException{
			String query = "Update rentalBook set state = 1 where bookID = ?";
			Object[] param = new Object[] { bookID };
			
			try {	
				jdbcUtil.setSqlAndParameters(query, param);
				int result = jdbcUtil.executeUpdate();	
				return result;
			} catch (Exception ex) {
				jdbcUtil.rollback();
				ex.printStackTrace();
			} finally {		
				jdbcUtil.commit();
				jdbcUtil.close();	// resource 반환
			}		
			return 0;
		}
		
		//rentBook 대여하기. : 1.rentalInfo에 새 레코드 추가. 2. rentalBook의 상태를 true로 바꿈. 3. 책 정보의 rentalCnt를 1 추가.
		public void rentBook(int bookID, String memberID) throws SQLException{
			int insertR = insertRentalInfo(bookID, memberID);
			BookInfoDao bookInfoDao = new BookInfoDao();
			
			if(insertR != 0) {
				int updateStateR = updateRentalBook_state(bookID);
				if(updateStateR != 0) {
					int plusCntR = bookInfoDao.plusRentalCnt(bookID);
					if(plusCntR == 0) {
						System.out.println("ERROR! update plus Bookinfo's State Fail!");
					}
				} else {
					System.out.println("ERROR! update RentalBook State Fail!");
				}
			} else {
				System.out.println("ERROR! insert RentalInfo Fail!");
			}
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


		public rentalInfo findRentInfo(int bookID) {
			
			String query = "select rentalid, sellerid, rentalerid, rentalDate, returnDate, bookname, r.point as point, i.state as state " + 
	          		"from rentalBook r inner join bookinfo b on b.bookinfoID = r.bookinfoID " + 
	          		"inner join rentalInfo i on i.bookid = r.bookid " +
	          		"where i.bookid = ? ";
			jdbcUtil.setSqlAndParameters(query, new Object[] {bookID});
			
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

		
}
