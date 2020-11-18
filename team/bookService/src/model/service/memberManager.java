package model.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Member;
import model.rentalBook;
import model.dao.MemberDao;

public class memberManager {
	
	private static memberManager memMan = new memberManager();
	private MemberDao memberDAO;

	private memberManager() {
		try {
			memberDAO = new MemberDao();
		} catch (Exception e) {
			e.printStackTrace();
		}			
	}
	
	public static memberManager getInstance() {
		return memMan;
	}
	
	public int create(Member member) throws SQLException, ExistingUserException {
		if (memberDAO.existingUser(member.getMemberID()) == true) {
			throw new ExistingUserException(member.getMemberID() + "는 존재하는 아이디입니다.");
		}
		return memberDAO.register(member);
	}
	
	public int update(Member member) throws SQLException, MemberNotFoundException {
		findMember(member.getMemberID());
		return memberDAO.update(member);
	}	

	public int remove(String memberID) throws SQLException, MemberNotFoundException {
		findMember(memberID);
		return memberDAO.remove(memberID);
	}

	public Member findMember(String memberID)
		throws SQLException, MemberNotFoundException {
		Member member = memberDAO.findUser(memberID);
		
		if (member == null) {
			throw new MemberNotFoundException(memberID + "는 존재하지 않는 아이디입니다.");
		}		
		return member;
	}	
	
	public boolean login(String memberID, String password) throws SQLException, MemberNotFoundException {
		Member member = findMember(memberID);
		
		if (member.getPassword().equals(password))
			return true;
		
		return false;
	}

	public MemberDao getMemberDAO() {
		return this.memberDAO;
	}
	
	public int regiseller(Member member) throws SQLException {
		return memberDAO.regiSeller(member);
	}
	
	public List<rentalBook> getRentalBookList(String memberID) throws SQLException {
		return memberDAO.getRentalBookList(memberID);
	}
	
	public boolean existingUser(String memberID) {
		return memberDAO.existingUser(memberID);
	}
  
}