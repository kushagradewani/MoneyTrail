package com.grownited.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMailMessage;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.grownited.entity.userEntity;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class MailService {
	
	@Autowired
	JavaMailSender javaMailSender;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
//	public void sendWelcomeMail(userEntity user) {
//		
//		SimpleMailMessage message = new SimpleMailMessage();
//		message.setTo(user.getEmail());
//		message.setFrom("moneytrailowner@gmail.com");
//        message.setSubject("Money Trail - Welcome to part of the Expense Manager");
//        message.setText("Hello "+user.getFirstName()+",Welcome to the money trail");
//
//        javaMailSender.send(message);
//		
//	}
	
	public void sendWelcomeMail(userEntity user) {
		
		MimeMessage message = javaMailSender.createMimeMessage();
		
		Resource resource = resourceLoader.getResource("classpath:templates/WelcomeMailTemplate.html");
		
		try {
			
			String html = new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
			
			MimeMessageHelper helper;
			

			String body = html
			        .replace("${name}", user.getFirstName())
			        .replace("${email}", user.getEmail())
			        .replace("${loginLink}", "http://localhost:9898/login")
			        .replace("${companyName}", "Money Trail");
			
			
			helper = new MimeMessageHelper(message,true);
			helper.setFrom("moneytrailowner@gmail.com");
			helper.setTo(user.getEmail());
			helper.setSubject("Money Trail - Welcome To Our Application");
			helper.setText(body,true);
			
			javaMailSender.send(message);
		}catch (MessagingException | IOException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	
	public void sendResetOtpMail(userEntity user, String otp) {

	    try {
	        MimeMessage message = javaMailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, true);

	        Resource resource = resourceLoader.getResource("classpath:templates/ResetPasswordOTP.html");
	        String html = new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);

	        String body = html
	                .replace("${fullName}", user.getFirstName())
	                .replace("${otp}", otp);

	        helper.setFrom("moneytrailowner@gmail.com");
	        helper.setTo(user.getEmail());
	        helper.setSubject("Money Trail - Password Reset OTP");
	        helper.setText(body, true);

	        javaMailSender.send(message);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

	public void sendPasswordSuccessMail(userEntity user) {

	    try {
	        MimeMessage message = javaMailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, true);

	        Resource resource = resourceLoader.getResource("classpath:templates/PasswordResetSuccess.html");
	        String html = new String(resource.getInputStream().readAllBytes(), StandardCharsets.UTF_8);
	        
	        String dateTime = LocalDateTime.now()
	                .format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss"));

	        String body = html
	                .replace("${fullName}", user.getFirstName())
	                .replace("${loginLink}", "http://localhost:9898/login")
	                .replace("${dateTime}", dateTime);

	        helper.setFrom("moneytrailowner@gmail.com");
	        helper.setTo(user.getEmail());
	        helper.setSubject("Money Trail - Password Changed Successfully");
	        helper.setText(body, true);   // use body (with replacements)

	        javaMailSender.send(message);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

}
