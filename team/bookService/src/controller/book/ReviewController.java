package controller.book;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.bookInfo;
import model.rentalBook;
import model.review;
import model.service.BookInfoManager;
import model.service.ReviewManager;
import model.service.bookManager;

public class ReviewController implements Controller {
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
    	String bookInfoID = request.getParameter("bookinfoID");
    	String memberID = request.getParameter("memberID");
    	String reviewContent = new String(request.getParameter("reviewContent").getBytes("8859_1"), "UTF-8");
    	int preference = Integer.parseInt(request.getParameter("preference"));
    	
    	Date time = new Date();
    	
    	//검색으로 들어온게 아니라 rentalController에서 호출된 경우
    	if(memberID != null) {
			try {
				System.out.println(time);
				review review = new review(reviewContent, preference, time, memberID, bookInfoID); 
				ReviewManager reviewManager = ReviewManager.getInstance();
				reviewManager.create(review);
	    		
			} catch (Exception e) {
				return "redirect:/home";
			}
    	}
		
		request.setAttribute("review", "true");
		request.setAttribute("bookInfoID", bookInfoID);
		
		
    	return "/book/info";	
		
    }

}
