package controller.user;

import java.io.File;
import java.util.List;

import controller.Controller;
import model.rentalBook;
import model.service.bookManager;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


//���� ���ε带 ���� API�� ����ϱ� ����...
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;

//���� �뷮 �ʰ��� ���� Exception Ŭ������ FileUploadBase Ŭ������ Inner Ŭ������ ó��
import org.apache.commons.fileupload.servlet.*;

public class RBookUpdateController implements Controller {
	private static final Logger log = LoggerFactory.getLogger(RBookUpdateController.class);

	  @Override
	  public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		  boolean check = ServletFileUpload.isMultipartContent(request);
			rentalBook updateRBook = new rentalBook();
			String sellerID = null;
			String bookID = null;
			String bookInfoID = null;
			String explain = null;
			String state = null;
			String point = null;
			String condition = null;
			String bookname = null;
			String filename = null;
			int flag = 1;
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
			        		if(item.getFieldName().equals("sellerid")) sellerID = value;
			        		else if(item.getFieldName().equals("bookid")) bookID = value;
			        		else if(item.getFieldName().equals("bookinfoid")) bookInfoID = value;
			        		else if(item.getFieldName().equals("rexplain")) explain  = value;
			        		else if(item.getFieldName().equals("state")) state = value;
			        		else if(item.getFieldName().equals("rpoint")) point  = value;
			        		else if(item.getFieldName().equals("condition")) condition = value;
			        		else if(item.getFieldName().equals("bookname")) bookname  = value;
			        	}
			        	else {//�����̶��...
			        		if(item.getFieldName().equals("image")) {
			        		//key ���� picture�̸� ���� ������ �Ѵ�.
			        			filename = item.getName();//���� �̸� ȹ�� (�ڵ� �ѱ� ó�� ��)
			        			if(filename == null || filename.trim().length() == 0) { flag = 0; continue;}
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
				updateRBook.setBookID(Integer.valueOf(bookID));
				updateRBook.setSellerID(sellerID);
				updateRBook.setBookInfoID(bookInfoID);
				updateRBook.setExplain(explain);
				updateRBook.setPoint(Integer.parseInt(point));
				updateRBook.setState(Integer.parseInt(state));
				updateRBook.setCondition(Integer.parseInt(condition));
				updateRBook.setBookname(bookname);
				if(flag == 1)
					updateRBook.setImage(filename);
				
		   }
			
		   log.debug("Update User : {}", updateRBook);
		   try {
			   bookManager manager = bookManager.getInstance();
			   
			   if(flag == 0) {
				   rentalBook temp = manager.findRentBook(Integer.valueOf(bookID));
				   updateRBook.setImage(temp.getImage());
			   }
			   manager.updateRBook(updateRBook);			
			   return "redirect:/user/myPage";	
		   }catch (Exception e) {
			   request.setAttribute("updateRBookFailed", true);
			   return "redirect:/user/myPage";	
		   }
	  }

}
