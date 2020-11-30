package controller.book;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.bookInfo;
import model.service.BookInfoManager;

public class BookInfoController implements Controller{
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
    	String stype = request.getParameter("stype");
		String stype_g = request.getParameter("stype_g");
		String text = request.getParameter("search_kw");
		List<bookInfo> biList =null;
		
		if (text.equals(null))
			text = "";
		
		try {
			BookInfoManager book = BookInfoManager.getInstance();
    		//#biList = book.getSearchBookList(text);
		} catch (Exception e) {				
	        return "redirect:/home";
		}	
		// userList 객체와 현재 로그인한 사용자 ID를 request에 저장하여 전달
    	
    	request.setAttribute("biList", biList);
    	request.setAttribute("text", text);
		

		// 사용자 리스트 화면으로 이동(forwarding)
    	return "/book/info/form";	
		
    }
}
