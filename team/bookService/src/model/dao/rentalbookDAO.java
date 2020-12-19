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
		jdbcUtil = new JDBCUtil();	// JDBCUtil ��ü ����
	}
	
	
	/*rentalBook ��ü�� DAO _ retalBook insert, update, remove*/
	public int insert(rentalBook book) throws SQLException { 
		String sql = "Insert into rentalbook(bookID, memberID, bookInfoId, image, explain, point, condition, state)" + 
	 		"values(seq_bookID.NEXTVAL,?,?,?,?,?,?,?)";      
			
		Object[] param = new Object[] {book.getSellerID(), book.getBookInfoID(),book.getImage(), 
			book.getExplain(), book.getPoint(), book.getCondition(), book.getState()};            
	   
		String sql2 = "Update member set point = point + 50 where memberid = ?";
		Object[] param2 = new Object[] { book.getSellerID() };
	      try {  
	    	 jdbcUtil.setSqlAndParameters(sql, param);
	         int result = jdbcUtil.executeUpdate(); 
	         if(result != 1) {
	        	 throw new Exception();
	         }
	         
	         jdbcUtil.setSqlAndParameters(sql2, param2);
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
	         jdbcUtil.close();   // resource ��ȯ
	      }      
	      return 0;         
	   }
	   
	   public int update(rentalBook book) throws SQLException {
	      String sql = "UPDATE rentalBook "
	               + "SET memberID = ?, bookInfoId = ?, image = ?, explain = ?, point = ?, condition = ? "
	               + "WHERE bookID = ?";
	      Object[] param = new Object[] {book.getSellerID(), book.getBookInfoID(), 
	            book.getImage(), book.getExplain(), book.getPoint(), book.getCondition(), book.getBookID()};   
	      jdbcUtil.setSqlAndParameters(sql, param);   // JDBCUtil�� update���� �Ű� ���� ����
	         
	      try {            
	         int result = jdbcUtil.executeUpdate();   // update �� ����
	         return result;
	      } catch (Exception ex) {
	         jdbcUtil.rollback();
	         ex.printStackTrace();
	      }
	      finally {
	         jdbcUtil.commit();
	         jdbcUtil.close();   // resource ��ȯ
	      }      
	      return 0;
	   }

	   public int remove(int bookID) throws SQLException {
		   
         String sql = "DELETE FROM RENTALBOOK WHERE bookID = ?";      
         jdbcUtil.setSqlAndParameters(sql, new Object[] {bookID});   // JDBCUtil�� delete���� �Ű� ���� ����
         
	      try {            
	         int result = jdbcUtil.executeUpdate();   // delete �� ����
	         return result;
	      } catch (Exception ex) {
	         jdbcUtil.rollback();
	         ex.printStackTrace();
	      }
	      finally {
	         jdbcUtil.commit();
	         jdbcUtil.close();   // resource ��ȯ
	      }      
	      return 0;
	   }
	   
	   /* rentalBook�� �̿� �Լ�_ å  �뿩�ϱ�� �ݳ��ϱ�� (retalInfo insert�� rentalBook _ state update ��.*/

	   //rentalBook�� �ִ� ������ bookID�� ã�Ƽ� ��ü ���·� ��ȯ.
		public rentalBook findRentBook(int bookID) throws SQLException{
			String query = "select r.memberID, r.bookInfoID, image, explain, state, point, condition, bookname "
					+	"from rentalBook r join bookinfo b on r.bookinfoid = b.bookinfoid where bookID = ?";
			
			jdbcUtil.setSqlAndParameters(query, new Object[] {bookID});
			
			try {
				ResultSet rs = jdbcUtil.executeQuery();		// query ����
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
				jdbcUtil.close();		// resource ��ȯ
			}
			
			return null;
		}
		
		public List<rentalBook> findRentBookList(String bookInfoID) throws SQLException{
			String query = "select  r.bookID, r.memberID, r.bookInfoID, r.image, r.explain, r.state, r.point, r.condition, i.bookname  "
					+	"from rentalBook r, bookInfo i where r.bookInfoID = i.bookInfoID and r.bookInfoID = ?";
			jdbcUtil.setSqlAndParameters(query, new Object[] {bookInfoID});
			
			System.out.println(query);
			try {
				ResultSet rs = jdbcUtil.executeQuery();		// query ����
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
				jdbcUtil.close();		// resource ��ȯ
			}
			
			return null;
		}
		
		
		//rentBook �ݳ��ϱ�. : rentalBook�� ���¸� false�� �ٲ�. + ���⿡  rentalInfo�� ���� �ٲ��ִ� �۾� �ʿ�.
		public int returnBook(rentalInfo rInfo) throws SQLException {
			
			String query1 = "Update rentalBook set state = 0 where bookID = ?";
			Object[] param1 = new Object[] { rInfo.getBookID() };
			
			String query2 = "Update rentalInfo set state = 0 where rentalID = ?";
			Object[] param2 = new Object[] { rInfo.getRentalID() };
			
			String query3 = "Update rentalInfo set returndate = sysdate where rentalID = ?";
			Object[] param3 = new Object[] { rInfo.getRentalID() };
			
			String query4 = "Update member set point = point + 50 where memberid = ?";
			Object[] param4 = new Object[] { rInfo.getRentalerID() };
			
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
				
				return 1;
			} catch (Exception ex) {
				jdbcUtil.rollback();
				ex.printStackTrace();
			} finally {		
				jdbcUtil.commit();
				jdbcUtil.close();	// resource ��ȯ
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
				ResultSet rs = jdbcUtil.executeQuery();		// query ����
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
				jdbcUtil.close();		// resource ��ȯ
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
				ResultSet rs = jdbcUtil.executeQuery();		// query ����
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
				jdbcUtil.close();		// resource ��ȯ
			}
			
			return null;
		}



		public boolean existingBookInfo(String bookInfoID) {
			String sql = "SELECT count(*) FROM bookinfo WHERE bookinfoid=?";      
			jdbcUtil.setSqlAndParameters(sql, new Object[] {bookInfoID});	// JDBCUtil�� query���� �Ű� ���� ����

			try {
				ResultSet rs = jdbcUtil.executeQuery();		// query ����
				if (rs.next()) {
					int count = rs.getInt(1);
					return (count == 1 ? true : false);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				jdbcUtil.close();		// resource ��ȯ
			}
			return false;
		}


		//rentalBook �뿩�ϱ� ��� 
		public int rental(int rBookID, String sellerID, String rentalerID) throws SQLException, MemberNotFoundException {
			
			//�ش� �뿩 ������ ��ü�� ������.
			rentalBook rtBook = findRentBook(rBookID);
			
			//�ش� �뿩 ������ ���� ����(bookInfo)���� �ش� å�� �뿩 Ƚ�� ���� ( ���� �α�� ���� � ��� ����)
			String query1 = "Update bookInfo set rentalCnt = rentalCnt + 1 where bookinfoID = ?";
			Object[] param1 = new Object[] { rtBook.getBookInfoID() };
			
			//�ش� �뿩 ������ ���¸� �뿩 ������ �ǹ��ϴ�  1�� update
			String query2 = "Update rentalBook set state = 1 where bookID = ?";
			Object[] param2 = new Object[] { rBookID };
			
			//�뿩���� ���� ����Ʈ ������ �뿩������ ����Ʈ �� ��ŭ�� ����.
			String query3 = "Update Member set point = point - ? where MEMBERID = ?";
			Object[] param3 = new Object[] { rtBook.getPoint(), rentalerID };
			
			//�Ǹ����� ���� ����Ʈ ���� �뿩������ ����Ʈ �� ��ŭ�� ������.
			String query4 = "Update Member set point = point + ? where MEMBERID = ?";
			Object[] param4 = new Object[] { rtBook.getPoint(), sellerID };
			
			//rentalInfo ���̺�  �ش� �뿩 ������ ���� ���(����)�� insert ����. (�뿩��ȣ, �뿩��, �ݳ���, �Ǹ���, �뿩�� �� )
			String query5 = "Insert into rentalInfo values(seq_rentalID.NEXTVAL, sysdate, sysdate + 14, ?, ?, ?, 1)";
			Object[] param5 = new Object[] { sellerID, rentalerID, rBookID };
			
			//���� �������� ���ʷ� ����. ���ܻ��� �߻� �� catch ������ rollback ����.
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
				jdbcUtil.close();	// resource ��ȯ
			}		
			return 0;
			
		}

		
}
