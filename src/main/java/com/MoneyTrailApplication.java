package com;

import java.util.HashMap;
import java.util.Map;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.cloudinary.Cloudinary;

@SpringBootApplication
public class MoneyTrailApplication {

	public static void main(String[] args) {
		SpringApplication.run(MoneyTrailApplication.class, args);
	}
	
	@Bean
	PasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	Cloudinary getCloudinary() {
		Map<String, String> config = new HashMap<>();
		config.put("cloud_name", "dha1mtpgx");
		config.put("api_key", "636145747114298");
		config.put("api_secret", "xkbWJ-RZraH-PO5q5r8ux9hrdA8");
		return new Cloudinary(config);
	}

}
