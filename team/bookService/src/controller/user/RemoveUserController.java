package controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.rentalBook;
import model.service.bookManager;
import model.service.memberManager;

public class RemoveUserController implements Controller{
	private static final Logger log = LoggerFactory.getLogger(RBookUpdateController.class);

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (!UserSessionUtils.hasLogined(request.getSession())) {
            return "redirect:/user/login/form";		// login form 요청으로 redirect
        }
    	
    	String deleteId = UserSessionUtils.getLoginUserId(request.getSession());
    	
		log.debug("Delete User : {}", deleteId);			
		
    	memberManager manager = memberManager.getInstance();		
    	bookManager bmanager = bookManager.getInstance();	
    	
    	List<rentalBook> rBookList = null;
    	
    	try {
    		manager.remove(deleteId);	
	    	rBookList = manager.getRentalBookList(deleteId); 
	    	for(rentalBook rbook : rBookList) {
	    		bmanager.removeRBook(rbook.getBookID());	
	    	}
	    	HttpSession session = request.getSession();
			session.removeAttribute(UserSessionUtils.USER_SESSION_KEY);
			session.invalidate();		
	        
    	} catch(Exception e) {
    		 request.setAttribute("error", true);
    		 return "redirect:/user/myPage";
    	}
		return "redirect:/home";
	}

}
