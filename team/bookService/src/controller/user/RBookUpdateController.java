package controller.user;

import controller.Controller;
import model.rentalBook;
import model.service.bookManager;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class RBookUpdateController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(RBookUpdateController.class);

	  @Override
	  public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  rentalBook updateRBook = new rentalBook(
		    		Integer.valueOf(request.getParameter("bookid")),
		    		request.getParameter("sellerid"),
		    		request.getParameter("bookinfoid"),
		    		request.getParameter("image"),
		    		new String(request.getParameter("rexplain").getBytes("8859_1"), "UTF-8"),
		    		Integer.valueOf(request.getParameter("state")),
		    		Integer.valueOf(request.getParameter("rpoint")),
		    		Integer.valueOf(request.getParameter("condition")),
		    		request.getParameter("bookname")
				  );

		   log.debug("Update User : {}", updateRBook);

		   bookManager manager = bookManager.getInstance();
		   manager.updateRBook(updateRBook);			
		   return "redirect:/user/myPage";	
	  }

}
