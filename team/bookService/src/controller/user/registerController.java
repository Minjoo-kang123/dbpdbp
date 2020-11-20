package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.Member;
import model.service.ExistingUserException;
import model.service.memberManager;


public class registerController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(registerController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	Member member = new Member(
	    	request.getParameter("memberID"),
	    	new String(request.getParameter("name").getBytes("8859_1"), "UTF-8"),
	    	request.getParameter("email"),
	    	request.getParameter("phone"),
	    	request.getParameter("password"),
	    	Integer.parseInt(request.getParameter("gender")),
	    	new String(request.getParameter("address").getBytes("8859_1"), "UTF-8")
		);
    	
        log.debug("Create User : {}", member);
        log.debug("MemberID: " + request.getParameter("memberID")+
    	    	" name: " + request.getParameter("name")+
    	    	" email: " + request.getParameter("email")+
    	    	" phone: " + request.getParameter("phone")+
    	    	" password: " + request.getParameter("password")+
    	    	" gender: " + Integer.parseInt(request.getParameter("gender"))+
    	    	" address: " + request.getParameter("address"));
        try {
			memberManager manager = memberManager.getInstance();
			manager.create(member);
			return "redirect:/user/login/form";	
	        
		} catch (ExistingUserException e) {	// 예외 발생 시 회원가입 form으로 forwarding
            request.setAttribute("registerFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("member", member);
			return "/user/registerForm.jsp";
		}
		
	        
    }
}
