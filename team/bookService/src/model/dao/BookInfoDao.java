package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.bookInfo;
import model.rentalBook;
import model.rentalInfo;
import model.dao.rentalbookDAO;

public class BookInfoDao {
	
	private JDBCUtil jdbcUtil = null;

	   
	   public BookInfoDao() {         
	      jdbcUtil = new JDBCUtil();   // JDBCUtil 객체 생성
	   }
	   
	   //book 정보 추가 함수 -> 대강 만들 것이니 나중에 수정해주세요!
	   public int addBook(bookInfo book) throws SQLException{
	      String query = "Insert into bookInfo(bookinfoID, bookname, writer, publisher, category, bookimage, rentalCnt) values(?,?,?,?,?,?,?)";
	      Object[] param = new Object[] {book.getBookinfoID(),  book.getBookname(), book.getWriter(), book.getPublisher(), book.getCategory(), book.getBookimage(), book.getRentalCnt()};
	      jdbcUtil.setSqlAndParameters(query, param);
	      System.out.println(query + param);
	      
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
	   
	   //bookimage, rentalCnt 변경 -> 일단 이정도만
	   public int update(bookInfo book) throws SQLException {
	      String query = "update bookinfo set bookimage=?, rentalCnt=?"
	                  + "where bookinfoID=?";
	      
	      Object[] param = new Object[] {book.getBookimage(), book.getRentalCnt()};
	      jdbcUtil.setSqlAndParameters(query, param);
	      
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

	   /*개인 페이지에 개인 정보 출력  _ 대여해주는 책 리스트 정보, 대여 중인 책  리스트 정보  등은 각각 따로 가져오기.*/
	   public bookInfo findBookInfo(String bookinfoID) throws SQLException { /* memberId String 타입으로 이후 수정하기!!!!!!!!*/
		   
	      String query = "select bookinfoID, bookname, writer, publisher, category, bookimage, rentalCnt "
	               + "from bookInfo "
	               + "where bookinfoID = ?";
	      
	      jdbcUtil.setSqlAndParameters(query, new Object[] {bookinfoID});
	      
	      
	      try {  	  
	    	  ResultSet rs = jdbcUtil.executeQuery();      // query 실행
	    	  
	    	  if (rs.next()) {                  // 학생 정보 발견
	    		  
	    		  bookInfo book = new bookInfo(      // User 객체를 생성하여 학생 정보를 저장
	    				  bookinfoID,
	    				  rs.getString("bookname"),
	    				  rs.getString("writer"),
	    				  rs.getString("publisher"),
	    				  rs.getString("category"),
	    				  rs.getString("bookimage"),
	    				  rs.getInt("rentalCnt"));
	    		  
	    		  return book;
	    	  	}
	    	  
	      	} catch (Exception ex) {
	      		ex.printStackTrace();
	      	} finally {
	      		jdbcUtil.close();      // resource 반환
	      	}
	      
	      return null;
	      
	   }
	   
	   public int remove(String bookinfoID) throws SQLException {
	         String sql = "DELETE FROM BOOKINFO WHERE bookinfoID = ?";      
	           jdbcUtil.setSqlAndParameters(sql, new Object[] {bookinfoID});   // JDBCUtil에 delete문과 매개 변수 설정
	           
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
	   
	   //제목으로 검색하기!
	   public List<bookInfo> getSearchBookList(String text) throws SQLException {
		   String query = "select bookinfoID, bookname, writer, publisher, category, bookimage, rentalCnt "
	               + "from bookInfo "
	               + "where bookname like ?";
		   text = '%' + text + '%';
		   jdbcUtil.setSqlAndParameters(query, new Object[] {text});
		   
		   try {
			   ResultSet rs = jdbcUtil.executeQuery();
			   List<bookInfo> mSearchBookList = new ArrayList<bookInfo>();
			   
			   while(rs.next()) {
				   bookInfo book = new bookInfo();
				   
				   book.setBookinfoID(rs.getString("bookinfoID"));
				   book.setBookname(rs.getString("bookname"));
				   book.setWriter(rs.getString("writer"));
				   book.setPublisher(rs.getString("publisher"));
				   book.setCategory(rs.getString("category"));
				   book.setBookimage(rs.getString("bookimage"));
				   book.setRentalCnt(rs.getInt("rentalCnt"));
				   
				   mSearchBookList.add(book);
			   }
			   
			   return mSearchBookList;
		   	}catch(Exception ex) {}
	       
	       return null;
	   }
	    
		public boolean existingBook(String memberID) {
			String sql = "SELECT count(*) FROM bookInfo WHERE memberid=?";      
			jdbcUtil.setSqlAndParameters(sql, new Object[] {memberID});	// JDBCUtil에 query문과 매개 변수 설정

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
		
		//bookInfo에 있는 책정보에서 해당 책의 rental count를 1 더해줌.
		public int plusRentalCnt(int bookID) throws SQLException{
			rentalbookDAO retalbookdao = new rentalbookDAO();
			rentalBook rtBook = retalbookdao.findRentBook(bookID);
			String query = "Update bookInfo set rentalCnt = rentalCnt + 1 where bookinfoID = ?";
			Object[] param = new Object[] { rtBook.getBookInfoID() };
					
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

}
