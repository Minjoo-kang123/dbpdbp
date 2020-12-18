package controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import python.recModel;

public class BookRecommandController implements Controller{
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		System.out.println("start!");
    	String title = request.getParameter("re_title");
    	recModel model = new recModel();
		int result = -1;
		
		System.out.println("start2!");
		result = model.recommandBook(title);
		System.out.println("start3!");
		
		request.setAttribute("result", result);
		
    	return "/book/recommand/form";	
		
    }

}
