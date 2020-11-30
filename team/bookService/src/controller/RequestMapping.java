package controller;

import java.util.HashMap;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.book.*;
import controller.user.*;


public class RequestMapping {
    private static final Logger logger = LoggerFactory.getLogger(DispatcherServlet.class);
    
    // �� ��û uri�� ���� controller ��ü�� ������ HashMap ����
    private Map<String, Controller> mappings = new HashMap<String, Controller>();

    public void initMapping() {
    	// �� uri�� �����Ǵ� controller ��ü�� ���� �� ����
        mappings.put("/home", new ForwardController("homePage01.jsp"));
        
        mappings.put("/user/login/form", new ForwardController("/user/loginForm.jsp"));
        mappings.put("/user/login", new LoginController());
        mappings.put("/user/logout", new LogoutController());
       
        mappings.put("/user/register/form", new ForwardController("/user/registerForm.jsp"));
        mappings.put("/user/register", new registerController());

        mappings.put("/book/search", new BookSearchController());
        mappings.put("/book/search/form", new ForwardController("/book/bookSearch.jsp"));
        
        mappings.put("/book/info", new BookInfoController());
        mappings.put("/book/info/form", new ForwardController("/book/bookInfoPage.jsp"));
       
        mappings.put("/user/myPage", new LoadingMyInfoController());
        
        mappings.put("/user/rbook/info", new LoadingMyrBookController());
        mappings.put("/user/rbook/update", new RBookUpdateController());
        mappings.put("/user/rbook/remove", new RBookRemoveController());
        
        mappings.put("/user/ibook/info", new LoadingMyiBookController());
        mappings.put("/user/ibook/return", new ReturniBookController());
     
        logger.info("Initialized Request Mapping!");
    }

    public Controller findController(String uri) {	
    	// �־��� uri�� �����Ǵ� controller ��ü�� ã�� ��ȯ
        return mappings.get(uri);
    }
}