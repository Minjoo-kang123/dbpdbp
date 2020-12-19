package controller.user;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import controller.Controller;
import model.rentalBook;
import model.service.BookNotFoundException;
import model.service.bookManager;

//���� ���ε带 ���� API�� ����ϱ� ����...
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;

//���� �뷮 �ʰ��� ���� Exception Ŭ������ FileUploadBase Ŭ������ Inner Ŭ������ ó��
import org.apache.commons.fileupload.servlet.*;


public class NewRBookController implements Controller {
	 private static final Logger log = LoggerFactory.getLogger(registerController.class);
	
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		boolean check = ServletFileUpload.isMultipartContent(request);
		rentalBook rbook = new rentalBook();
		String sellerID = null;
		String bookInfoID = null;
		String explain = null;
		String state = null;
		String point = null;
		String condition = null;
		String bookname = null;
		String filename = null;
		
		if(check) {//���� ������ ���Ե� ���°� �´ٸ�
			
			// �Ʒ��� ���� �ϸ� Tomcat ���ο� ����� ������Ʈ�� ���� �ؿ� upload ������ ������ 
			/*
			 * ServletContext context = request.getServletContext(); String path =
			 * context.getRealPath("/upload");
			 */
			File dir = new File("C:/upload");
			
			if(!dir.exists()) dir.mkdir();
		
			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
				
		        factory.setSizeThreshold(10 * 1024);
		        factory.setRepository(dir);           
		
		        ServletFileUpload upload = new ServletFileUpload(factory);
		        upload.setSizeMax(10 * 1024 * 1024);
		        upload.setHeaderEncoding("utf-8");
		                        
		        List<FileItem> items = (List<FileItem>)upload.parseRequest(request);
		        
		        //upload ��ü�� ���۵Ǿ� �� ��� �����͸� Collection ��ü�� ��´�.
		        for(int i = 0; i < items.size(); ++i) {
		        	FileItem item = (FileItem)items.get(i);
		        	String value = item.getString("utf-8");
		        	
		        	if(item.isFormField()) {//�Ϲ� �� �����Ͷ��...                		
		        		if(item.getFieldName().equals("sellerID")) sellerID = value;
		        		else if(item.getFieldName().equals("bookInfoID")) bookInfoID = value;
		        		else if(item.getFieldName().equals("explain")) explain  = value;
		        		else if(item.getFieldName().equals("state")) state = value;
		        		else if(item.getFieldName().equals("point")) point  = value;
		        		else if(item.getFieldName().equals("condition")) condition = value;
		        		else if(item.getFieldName().equals("bookname")) bookname  = value;
		        	}
		        	else {//�����̶��...
		        		if(item.getFieldName().equals("image")) {
		        		//key ���� picture�̸� ���� ������ �Ѵ�.
		        			filename = item.getName();//���� �̸� ȹ�� (�ڵ� �ѱ� ó�� ��)
		        			if(filename == null || filename.trim().length() == 0) { 
		        				filename = "noImage.PNG";
		        				continue;
		        			}
		        			//������ ���۵Ǿ� ���� �ʾҴٸ� �ǳ� �ڴ�.
		        			filename = filename.substring(filename.lastIndexOf("\\") + 1);
		        			//���� �̸��� ������ ��ü ��α��� �����ϱ� ������ �̸� �κи� �����ؾ� �Ѵ�.
		        			//���� C:\Web_Java\aaa.gif��� �ϸ� aaa.gif�� �����ϱ� ���� �ڵ��̴�.
		        			File file = new File(dir, filename);
		        			item.write(file);
		        			//������ upload ��ο� ������ �����Ѵ�.
		        			//FileItem ��ü�� ���� �ٷ� ��� ������ �� �ִ�.
		        		}
		        	}
		        }
		        
			}catch(SizeLimitExceededException e) {
			//���ε� �Ǵ� ������ ũ�Ⱑ ������ �ִ� ũ�⸦ �ʰ��� �� �߻��ϴ� ����ó��
				e.printStackTrace();           
		    }catch(FileUploadException e) {
		    //���� ���ε�� ���õǾ� �߻��� �� �ִ� ���� ó��
		        e.printStackTrace();
		    }catch(Exception e) {            
		        e.printStackTrace();
		    }
			
			
			rbook.setBookID(0);
			rbook.setSellerID(sellerID);
			rbook.setBookInfoID(bookInfoID);
			rbook.setExplain(explain);
			rbook.setState(Integer.parseInt(state));
			rbook.setCondition(Integer.parseInt(condition));
			rbook.setPoint(Integer.parseInt(point));
			rbook.setBookname(bookname);
			rbook.setImage(filename);
			
		}
        
        try {
			bookManager manager = bookManager.getInstance();
			manager.createRBook(rbook);
			log.debug("Create rBook : {}", rbook);
			return "redirect:/user/myPage";	
	        
		} catch (BookNotFoundException e) {	// ���� �߻� �� ȸ������ form���� forwarding
            request.setAttribute("uploadFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("rbook", rbook); // ���� å ���� �����ؼ� �ѱ�.
			return "/user/uploadRBookForm.jsp";
		}
    		
	}
}
