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


//파일 업로드를 위한 API를 사용하기 위해...
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.FileUploadBase.SizeLimitExceededException;

//파일 용량 초과에 대한 Exception 클래스를 FileUploadBase 클래스의 Inner 클래스로 처리
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
			
			if(check) {//파일 전송이 포함된 상태가 맞다면
				
				// 아래와 같이 하면 Tomcat 내부에 복사된 프로젝트의 폴더 밑에 upload 폴더가 생성됨 
				ServletContext context = request.getServletContext();
				String path = context.getRealPath("/upload");
				File dir = new File(path);
				
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
			        		if(item.getFieldName().equals("sellerid")) sellerID = value;
			        		else if(item.getFieldName().equals("bookid")) bookID = value;
			        		else if(item.getFieldName().equals("bookinfoid")) bookInfoID = value;
			        		else if(item.getFieldName().equals("rexplain")) explain  = value;
			        		else if(item.getFieldName().equals("state")) state = value;
			        		else if(item.getFieldName().equals("rpoint")) point  = value;
			        		else if(item.getFieldName().equals("condition")) condition = value;
			        		else if(item.getFieldName().equals("bookname")) bookname  = value;
			        	}
			        	else {//파일이라면...
			        		if(item.getFieldName().equals("image")) {
			        		//key 값이 picture이면 파일 저장을 한다.
			        			filename = item.getName();//파일 이름 획득 (자동 한글 처리 됨)
			        			if(filename == null || filename.trim().length() == 0) continue;
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
				updateRBook.setBookID(Integer.valueOf(bookID));
				updateRBook.setSellerID(sellerID);
				updateRBook.setBookInfoID(bookInfoID);
				updateRBook.setExplain(explain);
				updateRBook.setPoint(Integer.parseInt(point));
				updateRBook.setState(Integer.parseInt(state));
				updateRBook.setCondition(Integer.parseInt(condition));
				updateRBook.setBookname(bookname);
				updateRBook.setImage(dir + "\\" + filename);
		   }
			
		   log.debug("Update User : {}", updateRBook);
		   try {
			   bookManager manager = bookManager.getInstance();
			   manager.updateRBook(updateRBook);			
			   return "redirect:/user/myPage";	
		   }catch (Exception e) {
			   request.setAttribute("updateRBookFailed", true);
			   return "redirect:/user/myPage";	
		   }
	  }

}
