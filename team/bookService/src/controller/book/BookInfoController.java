package controller.book;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.bookInfo;
import model.rentalBook;
import model.review;
import model.service.BookInfoManager;
import model.service.BookNotFoundException;
import model.service.bookManager;
import model.service.ReviewManager;

public class BookInfoController implements Controller{
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
    	String bookInfoID = request.getParameter("bookID");
    	
    	//�˻����� ���°� �ƴ϶� rentalController���� ȣ��� ���
    	if (request.getAttribute("review") != null) {
    		bookInfoID = (String) request.getAttribute("bookInfoID");
    	}
    	else if(bookInfoID == null) {
    		bookInfoID = (String) request.getAttribute("bookID"); 
    		
    		request.setAttribute("rentalOK", request.getAttribute("rentalOK"));
    		request.setAttribute("RentalException", request.getAttribute("RentalException"));
    		request.setAttribute("Exception", request.getAttribute("Exception"));
			request.setAttribute("exception", request.getAttribute("exception"));
    	}
		bookInfo book = new bookInfo();
		List<rentalBook> rbList = null;
		
		List<review> rwList = null;
		
		try {
			BookInfoManager bookInfoManager = BookInfoManager.getInstance();
			book = bookInfoManager.findBookInfo(bookInfoID);
			
			bookManager bManager = bookManager.getInstance();
			rbList = bManager.findRentBookList(bookInfoID);
			
			ReviewManager reviewManager = ReviewManager.getInstance();
			rwList = reviewManager.getReviewList(bookInfoID);
    		
		} catch (Exception e) {
			return "redirect:/home";
		}
		
		request.setAttribute("book", book);
		request.setAttribute("rbList", rbList);
		request.setAttribute("text", request.getParameter("text"));
		request.setAttribute("stype", request.getParameter("stype"));
		request.setAttribute("stype_g", request.getParameter("stype_g"));
		request.setAttribute("rwList", rwList);
		
		
    	return "/book/info/form";	
		
    }
}
