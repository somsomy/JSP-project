package email;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class JoinEmail {
	public static void naverMailSend(String to) {
		String host = "smtp.naver.com";
		String user = "yun07003@naver.com"; 
		
		Properties props = new Properties(); 
		props.put("mail.smtp.host", host); 
		props.put("mail.smtp.port", 587); 
		props.put("mail.smtp.auth", "true"); 
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			protected PasswordAuthentication getPasswordAuthentication() { 
				return new PasswordAuthentication(user, password); } 
		}); 
		
		try { 
			MimeMessage message = new MimeMessage(session); 
			message.setFrom(new InternetAddress(user)); 
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to)); 

			message.setSubject("고양이의 하루에 가입하신 것을 환영합니다!"); 
			
			message.setText("가입 축하드립니다."); 
			
			Transport.send(message); 
			System.out.println("Success Message Send"); } 
		
		catch (MessagingException e) { 
			e.printStackTrace(); 
		} 
		
	}

	}
