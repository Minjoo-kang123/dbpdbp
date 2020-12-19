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

//파일 업로드를 위한 API를 사용하기 위해...
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;

//파일 용량 초과에 대한 Exception 클래스를 FileUploadBase 클래스의 Inner 클래스로 처리
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
		
		if(check) {//파일 전송이 포함된 상태가 맞다면
			
			// 아래와 같이 하면 Tomcat 내부에 복사된 프로젝트의 폴더 밑에 upload 폴더가 생성됨 
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
		        
		        //upload 객체에 전송되어 온 모든 데이터를 Collection 객체에 담는다.
		        for(int i = 0; i < items.size(); ++i) {
		        	FileItem item = (FileItem)items.get(i);
		        	String value = item.getString("utf-8");
		        	
		        	if(item.isFormField()) {//일반 폼 데이터라면...                		
		        		if(item.getFieldName().equals("sellerID")) sellerID = value;
		        		else if(item.getFieldName().equals("bookInfoID")) bookInfoID = value;
		        		else if(item.getFieldName().equals("explain")) explain  = value;
		        		else if(item.getFieldName().equals("state")) state = value;
		        		else if(item.getFieldName().equals("point")) point  = value;
		        		else if(item.getFieldName().equals("condition")) condition = value;
		        		else if(item.getFieldName().equals("bookname")) bookname  = value;
		        	}
		        	else {//파일이라면...
		        		if(item.getFieldName().equals("image")) {
		        		//key 값이 picture이면 파일 저장을 한다.
		        			filename = item.getName();//파일 이름 획득 (자동 한글 처리 됨)
		        			if(filename == null || filename.trim().length() == 0) { 
		        				filename = "noImage.PNG";
		        				continue;
		        			}
		        			//파일이 전송되어 오지 않았다면 건너 뛴다.
		        			filename = filename.substring(filename.lastIndexOf("\\") + 1);
		        			//파일 이름이 파일의 전체 경로까지 포함하기 때문에 이름 부분만 추출해야 한다.
		        			//실제 C:\Web_Java\aaa.gif라고 하면 aaa.gif만 추출하기 위한 코드이다.
		        			File file = new File(dir, filename);
		        			item.write(file);
		        			//파일을 upload 경로에 실제로 저장한다.
		        			//FileItem 객체를 통해 바로 출력 저장할 수 있다.
		        		}
		        	}
		        }
		        
			}catch(SizeLimitExceededException e) {
			//업로드 되는 파일의 크기가 지정된 최대 크기를 초과할 때 발생하는 예외처리
				e.printStackTrace();           
		    }catch(FileUploadException e) {
		    //파일 업로드와 관련되어 발생할 수 있는 예외 처리
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
	        
		} catch (BookNotFoundException e) {	// 예외 발생 시 회원가입 form으로 forwarding
            request.setAttribute("uploadFailed", true);
			request.setAttribute("exception", e);
			request.setAttribute("rbook", rbook); // 이전 책 내용 저장해서 넘김.
			return "/user/uploadRBookForm.jsp";
		}
    		
	}
}
