package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.rentalBook;
import model.service.BookNotFoundException;
import model.service.NoExistingBookInfoException;
import model.service.bookManager;

public class NewRBookController implements Controller {
	 private static final Logger log = LoggerFactory.getLogger(registerController.class);
	
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		rentalBook rbook = new rentalBook(
    	    	0, request.getParameter("sellerID"),
    	    	request.getParameter("bookInfoID"),
    	    	request.getParameter("image"),
    	    	new String(request.getParameter("explain").getBytes("8859_1"), "UTF-8"),
    	    	Integer.parseInt(request.getParameter("state")),
    	    	Integer.parseInt(request.getParameter("point")),
    	    	Integer.parseInt(request.getParameter("condition")),
    	    	new String(request.getParameter("bookname").getBytes("8859_1"), "UTF-8")
    		);
        	
        log.debug("Create rBook : {}", rbook);
        
        try {
			bookManager manager = bookManager.getInstance();
			manager.createRBook(rbook);
			return "redirect:/user/myPage";	
	        
		} catch (BookNotFoundException e) {	// 예외 발생 시 회원가입 form으로 forwarding
            request.setAttribute("uploadFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("rbook", rbook); // 이전 책 내용 저장해서 넘김.
			return "/user/uploadRBookForm.jsp";
		}
    		
    }
}
