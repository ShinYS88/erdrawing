package kr.or.ddit.api.mail;

public interface IMailService {

		public boolean send(String subject,String text,String from, String to, String filePath);
}
