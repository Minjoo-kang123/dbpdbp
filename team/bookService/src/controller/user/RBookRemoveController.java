package controller.user;

import controller.Controller;
import model.rentalBook;
import model.service.bookManager;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RBookRemoveController implements Controller{
	private static final Logger log = LoggerFactory.getLogger(RBookUpdateController.class);

	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response)	throws Exception {
		boolean check = ServletFileUpload.isMultipartContent(request);
		String bookID = null;
		
		if(check) {//파일 전송이 포함된 상태가 맞다면
			try {
				DiskFileItemFactory factory = new DiskFileItemFactory();
		
		        ServletFileUpload upload = new ServletFileUpload(factory);
		        upload.setSizeMax(10 * 1024 * 1024);
		        upload.setHeaderEncoding("utf-8");
		                        
		        List<FileItem> items = (List<FileItem>)upload.parseRequest(request);
		        
		        //upload 객체에 전송되어 온 모든 데이터를 Collection 객체에 담는다.
		        for(int i = 0; i < items.size(); ++i) {
		        	FileItem item = (FileItem)items.get(i);
		        	String value = item.getString("utf-8");
		        	
		        	if(item.isFormField()) //일반 폼 데이터라면...                		
		        		if(item.getFieldName().equals("bookid")) bookID = value;
		 
		        }
		        
			}catch(Exception e) {            
		        e.printStackTrace();
		    }
		
		}
		int deleteId = Integer.valueOf(bookID);
    	log.debug("Delete User : {}", deleteId);

    	bookManager manager = bookManager.getInstance();		
		manager.removeRBook(deleteId);				
		
		return "redirect:/user/myPage";
	}
}
