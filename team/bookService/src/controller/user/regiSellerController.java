package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import model.service.MemberNotFoundException;
import model.service.memberManager;

public class regiSellerController implements Controller {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String memberID = UserSessionUtils.getLoginUserId(request.getSession());
		memberManager manager = memberManager.getInstance();
		int seller  = -1;
	
		try {
    		seller = manager.regiseller(memberID);
			
		} catch (Exception e) {				
	        return "redirect:/home";
		}
		
		return "redirect:/user/myPage";
	}

}
