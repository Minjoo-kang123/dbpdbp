package controller.book;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.bookInfo;
import model.service.BookInfoManager;
import python.recModel;

public class BookRecommandController implements Controller{
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		
    	String title = request.getParameter("re_title");
    	recModel model = new recModel();
		int result = -1;
		List<bookInfo> biList =null;
		
		result = model.recommandBook(title);
		
		System.out.println(result + "%");
		
		try {
			BookInfoManager book = BookInfoManager.getInstance();
    		biList = book.getSearchBookList("", "all", result + "%");
		} catch (Exception e) {				
	        return "redirect:/home";
		}	
		
		if (biList.size() > 3)
		{
			Collections.shuffle(biList);
			biList = new ArrayList<>(biList.subList(0, 3));
		}
		
		
		request.setAttribute("biList", biList);
		request.setAttribute("result", result);
		
    	return "/book/recommand/form";	
		
    }

}
