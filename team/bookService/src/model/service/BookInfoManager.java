package model.service;

import java.sql.SQLException;
import java.util.List;

import model.bookInfo;
import model.dao.BookInfoDao;

public class BookInfoManager {
	private static BookInfoManager bsMan = new BookInfoManager();
	private BookInfoDao bookInfoDAO;

	private BookInfoManager() {
		try {
			bookInfoDAO = new BookInfoDao();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static BookInfoManager getInstance() {
		return bsMan;
	}
	
	public int create(bookInfo book) throws SQLException, ExistingUserException {
		return bookInfoDAO.addBook(book);
	}
	
	public int update(bookInfo book) throws SQLException, MemberNotFoundException {
		return bookInfoDAO.update(book);
	}	

	public int remove(String bookinfoID) throws SQLException, MemberNotFoundException {
		return bookInfoDAO.remove(bookinfoID);
	}
	
	public bookInfo findBookInfo(String bookInfoID) throws SQLException, BookNotFoundException {
		bookInfo bInfo = bookInfoDAO.findBookInfo(bookInfoID);
		if(bInfo == null) {
			throw new BookNotFoundException(bookInfoID + "는 존재하지 않는 북인포아이디입니다.");
		}
		return bInfo;
	}

	
	public List<bookInfo> getSearchBookList(String text, String stype, String stype_g) throws SQLException {
		return bookInfoDAO.getSearchBookList(text, stype, stype_g);
	}
	
	public List<bookInfo> getAllBookList() throws SQLException {
		return bookInfoDAO.getAllBookList();
	}

	public BookInfoDao getBookInfoDAO() {
		return this.bookInfoDAO;
	}
	
	public boolean existingBook(String bookinfoID) {
		return bookInfoDAO.existingBook(bookinfoID);
	}
	
}
