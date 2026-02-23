package com.grownited.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.grownited.entity.userEntity;

@Service
public class MailService {
	
	@Autowired
	JavaMailSender javaMailSender;
	
	public void sendWelcomeMail(userEntity user) {
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(user.getEmail());
		message.setFrom("moneytrailowner@gmail.com");
        message.setSubject("Money Trail - Welcome to part of the Expense Manager");
        message.setText("Hello "+user.getFirstName()+",Welcome to the money trail");

        javaMailSender.send(message);
		
	}

}
