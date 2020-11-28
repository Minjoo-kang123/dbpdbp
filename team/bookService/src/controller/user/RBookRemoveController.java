package controller.user;

import controller.Controller;
import model.rentalBook;
import model.service.bookManager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RBookRemoveController implements Controller{
	private static final Logger log = LoggerFactory.getLogger(RBookUpdateController.class);

	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
		int deleteId = Integer.valueOf(request.getParameter("bookid"));
    	log.debug("Delete User : {}", deleteId);

    	bookManager manager = bookManager.getInstance();		
		manager.removeRBook(deleteId);				
		
		return "redirect:/user/myPage";
	}
}
