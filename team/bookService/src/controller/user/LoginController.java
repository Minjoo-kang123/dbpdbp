package controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Controller;
import model.service.memberManager;

//import model.service.UserManager;
//db 스키마 및 레코드 존재x, 임시로 돌아가게 꾸밈.
public class LoginController implements Controller {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String userId = request.getParameter("userId");
		String password = request.getParameter("password");
		
		try {
			memberManager manager = memberManager.getInstance();
			
			// 세션에 사용자 아이디 저장			
			if (manager.login(userId, password)) {
				HttpSession session = request.getSession();
				session.setAttribute(UserSessionUtils.USER_SESSION_KEY, userId);
				return "redirect:/home";	
			}
			
			request.setAttribute("loginFailed", true);
            return "/user/loginForm.jsp";	
            
		} catch (Exception e) {
			/* UserNotFoundException이나 PasswordMismatchException 발생 시
			 * 다시 login form을 사용자에게 전송하고 오류 메세지도 출력
			 */
            request.setAttribute("loginFailed", true);
			request.setAttribute("exception", e);
            return "/user/loginForm.jsp";			
		}	
    }
}
