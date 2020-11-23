package controller.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.service.MemberNotFoundException;
import model.service.memberManager;
import model.*;

public class LoadingMyInfoController implements Controller {
	 @Override
	    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
			// 로그인 여부 확인
	    	if (!UserSessionUtils.hasLogined(request.getSession())) {
	            return "redirect:/user/login/form";		// login form 요청으로 redirect
	        }
	    	
	    	String memberID = UserSessionUtils.getLoginUserId(request.getSession());
	    	
			memberManager manager = memberManager.getInstance();
			
			List<rentalInfo> rInfoList = null;
			List<rentalBook> rBookList = null;
			Member member = null;
			// List<User> userList = manager.findUserList(currentPage, countPerPage);
	    	try {
	    		rInfoList = manager.getRentalInfoList(memberID);
	    		rBookList = manager.getRentalBookList(memberID);
				member = manager.findMember(memberID);	// 사용자 정보 검색
			} catch (MemberNotFoundException e) {				
		        return "redirect:/home";
			}	
			// userList 객체와 현재 로그인한 사용자 ID를 request에 저장하여 전달
	    	
	    	request.setAttribute("rInfoList", rInfoList);
			request.setAttribute("rBookList", rBookList);				
			request.setAttribute("curMember", member);
			

			// 사용자 리스트 화면으로 이동(forwarding)
			return "userInfoPage.jsp";     
	    }
}
