package model.service;

public class NoExistingBookInfoException extends Exception {

	private static final long serialVersionUID = 1L;

	public NoExistingBookInfoException() {
		super();
	}

	public NoExistingBookInfoException(String arg0) {
		super(arg0);
	}
}