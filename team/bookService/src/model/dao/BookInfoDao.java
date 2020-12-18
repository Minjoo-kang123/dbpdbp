package model.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.bookInfo;
import model.rentalBook;
import model.dao.rentalbookDAO;

public class BookInfoDao {
	
	private JDBCUtil jdbcUtil = null;

	   
	   public BookInfoDao() {         
	      jdbcUtil = new JDBCUtil();   // JDBCUtil ��ü ����
	   }
	   
	   //book ���� �߰� �Լ� -> �밭 ���� ���̴� ���߿� �������ּ���!
	   public int addBook(bookInfo book) throws SQLException{
	      String query = "Insert into bookInfo(bookinfoID, bookname, writer, publisher, category, bookimage, rentalCnt, releaseDate, summary) values(?,?,?,?,?,?,?,?,?)";
	      Object[] param = new Object[] {book.getBookinfoID(),  book.getBookname(), book.getWriter(), book.getPublisher(), book.getCategory(), book.getBookimage(), book.getRentalCnt(), book.getReleaseDate(), book.getSummary()};
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
	         jdbcUtil.close();   // resource ��ȯ
	      }      
	      return 0;
	   }
	   
	   //bookimage, rentalCnt ���� -> �ϴ� ��������
	   public int update(bookInfo book) throws SQLException {
	      String query = "update bookinfo set bookimage=?, rentalCnt=?"
	                  + "where bookinfoID=?";
	      
	      Object[] param = new Object[] {book.getBookimage(), book.getRentalCnt()};
	      jdbcUtil.setSqlAndParameters(query, param);
	      
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

	   /*���� �������� ���� ���� ���  _ �뿩���ִ� å ����Ʈ ����, �뿩 ���� å  ����Ʈ ����  ���� ���� ���� ��������.*/
	   public bookInfo findBookInfo(String bookinfoID) throws SQLException { /* memberId String Ÿ������ ���� �����ϱ�!!!!!!!!*/
		   
	      String query = "select bookinfoID, bookname, writer, publisher, category, bookimage, rentalCnt, releaseDate, summary "
	               + "from bookInfo "
	               + "where bookinfoID = ?";
	      
	      jdbcUtil.setSqlAndParameters(query, new Object[] {bookinfoID});
	      
	      
	      try {  	  
	    	  ResultSet rs = jdbcUtil.executeQuery();      // query ����
	    	  
	    	  if (rs.next()) {                  
	    		  
	    		  bookInfo book = new bookInfo(      
	    				  bookinfoID,
	    				  rs.getString("bookname"),
	    				  rs.getString("writer"),
	    				  rs.getString("publisher"),
	    				  rs.getString("category"),
	    				  rs.getString("bookimage"),
	    				  rs.getInt("rentalCnt"),
	    				  rs.getDate("releaseDate"),
	    				  rs.getString("summary"));
	    		  
	    		  return book;
	    	  	}
	    	  
	      	} catch (Exception ex) {
	      		ex.printStackTrace();
	      	} finally {
	      		jdbcUtil.close();      // resource ��ȯ
	      	}
	      
	      return null;
	      
	   }
	   
	   public int remove(String bookinfoID) throws SQLException {
	         String sql = "DELETE FROM BOOKINFO WHERE bookinfoID = ?";      
	           jdbcUtil.setSqlAndParameters(sql, new Object[] {bookinfoID});   // JDBCUtil�� delete���� �Ű� ���� ����
	           
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
	   
	   //å ����Ʈ ������ ���� �Լ�
	   public List<bookInfo> getAllBookList() throws SQLException {
		   String query = "select bookinfoID, bookname, writer, publisher, category, bookimage, rentalCnt, releaseDate, summary "
	               + "from bookInfo ";
		   jdbcUtil.setSqlAndParameters(query, null);
		  
		   
		   try {
			   ResultSet rs = jdbcUtil.executeQuery();
			   List<bookInfo> allBookList = new ArrayList<bookInfo>();
			   
			   while(rs.next()) {
				   bookInfo book = new bookInfo();
				   
				   book.setBookinfoID(rs.getString("bookinfoID"));
				   book.setBookname(rs.getString("bookname"));
				   book.setWriter(rs.getString("writer"));
				   book.setPublisher(rs.getString("publisher"));
				   book.setCategory(rs.getString("category"));
				   book.setBookimage(rs.getString("bookimage"));
				   book.setRentalCnt(rs.getInt("rentalCnt"));
				   book.setReleaseDate(rs.getDate("releaseDate"));
				   book.setSummary(rs.getString("summary"));
				   
				   allBookList.add(book);
			   }
			   
			   return allBookList;
		   	}catch(Exception ex) {}
	       
	       return null;
	   }
	   
	   
	   //�������� �˻��ϱ�!
	   public List<bookInfo> getSearchBookList(String text, String stype, String stype_g) throws SQLException {
		   String query = "select bookinfoID, bookname, writer, publisher, category, bookimage, rentalCnt, releaseDate, summary "
	               + "from bookInfo ";
		   text = '%' + text + '%';
		   
		   if (stype_g.equals("all"))
		   {
			   stype_g = "%%";
		   }
		   
		   if (stype.equals("all"))
		   {
			   query += "where category like ? and (writer like ? or bookname like ?) order by rentalCnt DESC ";
			   jdbcUtil.setSqlAndParameters(query, new Object[] {stype_g, text, text});
		   }
		   else if (stype.equals("subject"))
		   {
			   query += "where category like ? and bookname like ? order by rentalCnt DESC ";
			   jdbcUtil.setSqlAndParameters(query, new Object[] {stype_g, text});
		   }
		   else
		   {
			   query += "where category like ? and writer like ? order by rentalCnt DESC ";
			   jdbcUtil.setSqlAndParameters(query, new Object[] {stype_g, text});
		   }
		   
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
				   book.setReleaseDate(rs.getDate("releaseDate"));
				   book.setSummary(rs.getString("summary"));
				   
				   mSearchBookList.add(book);
			   }
			   
			   return mSearchBookList;
		   	}catch(Exception ex) {}
	       
	       return null;
	   }
	    
		public boolean existingBook(String memberID) {
			String sql = "SELECT count(*) FROM bookInfo WHERE memberid=?";      
			jdbcUtil.setSqlAndParameters(sql, new Object[] {memberID});	// JDBCUtil�� query���� �Ű� ���� ����

			try {
				ResultSet rs = jdbcUtil.executeQuery();		
				if (rs.next()) {
					int count = rs.getInt(1);
					return (count == 1 ? true : false);
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				jdbcUtil.close();
			}
			return false;
		}
		
		

}
