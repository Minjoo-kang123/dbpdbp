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

	public bookInfo findBook(String bookinfoID)
		throws SQLException, MemberNotFoundException {
		bookInfo book = bookInfoDAO.findBookInfo(bookinfoID);
		
		if (book == null) {
			throw new MemberNotFoundException(bookinfoID + "는 존재하지 않는 책입니다.");
		}		
		return book;
	}	
	
	public List<bookInfo> getSearchBookList(String text) throws SQLException {
		return bookInfoDAO.getSearchBookList(text);
	}

	public BookInfoDao getBookInfoDAO() {
		return this.bookInfoDAO;
	}
	
	public boolean existingBook(String bookinfoID) {
		return bookInfoDAO.existingBook(bookinfoID);
	}

}
