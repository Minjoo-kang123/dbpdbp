package model.service;

import java.sql.SQLException;
import java.util.List;

import model.Member;
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
	
	
	
	
	
	
}
