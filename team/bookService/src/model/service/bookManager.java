package model.service;

import java.sql.SQLException;
import java.util.List;

import model.Member;
import model.rentalBook;
import model.rentalInfo;
import model.dao.rentalbookDAO;

public class bookManager {
	
	private static bookManager bookMan = new bookManager();
	private rentalbookDAO rBookDAO;

	private bookManager() {
		try {
			rBookDAO = new rentalbookDAO();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static bookManager getInstance() {
		return bookMan;
	}

	
	public int createRBook(rentalBook rbook)throws SQLException, BookNotFoundException {
		if (rBookDAO.existingBookInfo(rbook.getBookInfoID()) != true) {
			throw new BookNotFoundException(rbook.getBookInfoID() + "는 존재하지 않는  bookInfoID(ISBN)입니다.");
		}
		return rBookDAO.insert(rbook);
	}	
	
	public int updateRBook(rentalBook rbook) throws SQLException, BookNotFoundException {
		findRentBook(rbook.getBookID());
		return rBookDAO.update(rbook);
	}	

	public int removeRBook(int bookID) throws SQLException, BookNotFoundException {
		findRentBook(bookID);
		return rBookDAO.remove(bookID);
	}

	public rentalBook findRentBook(int bookID)
		throws SQLException, BookNotFoundException {
		rentalBook rbook = rBookDAO.findRentBook(bookID);
		if (rbook == null) {
			throw new BookNotFoundException(bookID + "는 존재하지 않는 북아이디입니다.");
		}		
		return rbook;
	}	
	
	public List<rentalBook> findRentBookList(String bookInfoID) 
			throws SQLException, BookNotFoundException{
		List<rentalBook> rbList = rBookDAO.findRentBookList(bookInfoID);
		if (rbList == null) {
			throw new BookNotFoundException(bookInfoID + "는 존재하지 않는 북인포아이디입니다.");
		}
		return rbList;
	}

	public rentalbookDAO getrentalbookDAO() {
		return this.rBookDAO;
	}

	public rentalInfo findRentInfo(int bookID) throws SQLException, BookNotFoundException {
		rentalInfo rInfo = rBookDAO.findRentInfo(bookID);
		if (rInfo == null) {
			throw new BookNotFoundException(bookID + "는 존재하지 않는 북아이디입니다.");
		}		
		return rInfo;
	}
	
	public int returniBook(int bookID) throws SQLException, BookNotFoundException {
		rentalInfo rInfo = findRentInfo(bookID);
		return rBookDAO.returnBook(rInfo);
	}

	public int rental(int rBookID, String sellerID, String rentalerID) throws SQLException, MemberNotFoundException {
		return rBookDAO.rental(rBookID, sellerID, rentalerID);
	}

	
}