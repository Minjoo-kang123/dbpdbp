package controller.book;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.bookInfo;
import model.rentalBook;
import model.service.BookInfoManager;
import model.service.BookNotFoundException;
import model.service.bookManager;

public class BookInfoController implements Controller{
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
    	String bookInfoID = request.getParameter("bookID");
		bookInfo book = new bookInfo();
		List<rentalBook> rbList = null;
		
		try {
			BookInfoManager bookInfoManager = BookInfoManager.getInstance();
			book = bookInfoManager.findBookInfo(bookInfoID);
			
			bookManager bManager = bookManager.getInstance();
			rbList = bManager.findRentBookList(bookInfoID);   		
    		
		} catch (Exception e) {
			return "redirect:/home";
		}
		
		request.setAttribute("book", book);
		request.setAttribute("rbList", rbList);
		request.setAttribute("text", request.getParameter("text"));
		request.setAttribute("stype", request.getParameter("stype"));
		
    	return "/book/info/form";	
		
    }
}
