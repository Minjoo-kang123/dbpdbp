package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;

public class registerController implements Controller {
    private static final Logger log = LoggerFactory.getLogger(registerController.class);

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
    	String id = request.getParameter("userId");
    	String pw = request.getParameter("password");
    	String name = request.getParameter("name");
    	String email = request.getParameter("email");
    	String area = request.getParameter("area");
    	String phone = request.getParameter("phone");
		
        log.debug("Create User : {}", id + "/" + pw);

		return "redirect:/user/login/form";	
	        
    }
}
