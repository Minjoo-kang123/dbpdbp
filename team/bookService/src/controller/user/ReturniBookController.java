package controller.user;

import controller.Controller;
import model.rentalBook;
import model.service.bookManager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ReturniBookController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(ReturniBookController.class);

	  @Override
	  public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  
		   int rentalID = Integer.valueOf(request.getParameter("rentalID"));
		   log.debug("Update rentalInfo (return): {}", rentalID);

		   bookManager manager = bookManager.getInstance();
		   manager.returniBook(rentalID);			
		   return "redirect:/user/myPage";	
	  }

}
