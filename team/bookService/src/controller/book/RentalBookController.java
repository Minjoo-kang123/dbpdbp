package controller.book;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Controller;
import controller.user.UserSessionUtils;
import model.Member;
import model.rentalBook;
import model.service.RentalException;
import model.service.bookManager;
import model.service.memberManager;

public class RentalBookController implements Controller {
	@Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {	
		//빌리려고 하는 대여도서의 기본키(bookID)와, 현재 해당도서를 빌리려는 회원의 id 값을 가져옴.
		int bookID = Integer.valueOf(request.getParameter("rBookid"));
		String memberID = UserSessionUtils.getLoginUserId(request.getSession());
		
		rentalBook rbook = null;
		Member seller = null;
		Member rentaler = null;
		
		try {
			//빌리려고 대여 도서 객체를 가져옴.
			bookManager bManager = bookManager.getInstance();
			rbook = bManager.findRentBook(bookID);
			
			//판매자인 회원 객체와 대여자 회원의 객체를 각각 가져옴.
			memberManager mManager = memberManager.getInstance();
			seller = mManager.findMember(rbook.getSellerID()); //판매자 아이디는 대여도서 객체에서 꺼냄.
			rentaler = mManager.findMember(memberID);
    		
			//만약 대여자의 보유 포인트가 대여 도서의 포인트 보다 적다면 오류 발생.
			if(rentaler.getPoint() < rbook.getPoint()){
                throw new RentalException("bookID : " + bookID + " _책을 빌리기에 rentaler의 보유 포인트가 부족합니다.");
            }
			
			//만약 대여자가 자신이 올린 대여 도서를 대여하려한다면 오류 발생
			if(rentaler.getMemberID().equalsIgnoreCase(seller.getMemberID())) {
				 throw new RentalException("bookID : " + bookID + " _자신이 올린 책은 대여하실 수 없습니다.");
			}
			
			//bookManager를 통해 대여 관련 DAO 호출.
			if(bManager.rental(rbook.getBookID(), seller.getMemberID(), rentaler.getMemberID()) > 0) {
				request.setAttribute("rentalOK", true);
				request.setAttribute("bookID", rbook.getBookInfoID());
				
				if(mManager.updateSellerGrade(seller.getMemberID()) != 1) {
					throw new Exception();
				}
				return "/book/info";
			
			} else {
				throw new RentalException("<오류> bookID : " + bookID + " _대여 오류 _ 관리자에게 문의주세요");
			}
		} catch (RentalException e) {
			request.setAttribute("RentalException", true);
			request.setAttribute("exception", e);
			request.setAttribute("bookID", rbook.getBookInfoID());
            return "/book/info";	
		} catch (Exception e) {
			request.setAttribute("Exception", true);
			request.setAttribute("exception", e);
			request.setAttribute("bookID", rbook.getBookInfoID());
			return "/book/info";
		}
		
		//대여 성공  혹은 실패 후 일단 결과값을 가지고 이전 페이지인  /book/info 페이지로 돌아감.
    }
}
