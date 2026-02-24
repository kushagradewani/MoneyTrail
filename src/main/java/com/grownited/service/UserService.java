package com.grownited.service;

import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Optional;
import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.grownited.entity.userEntity;
import com.grownited.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MailService mailService;

    public void generateAndSendOtp(String email) {

        Optional<userEntity> optionalUser = userRepository.findByEmail(email);

        if (optionalUser.isPresent()) {

            userEntity user = optionalUser.get();

            String otp = String.format("%06d", new SecureRandom().nextInt(1000000));

            user.setOtp(otp);
            user.setOtpGeneratedTime(LocalDateTime.now());

            userRepository.save(user);

            mailService.sendResetOtpMail(user, otp);
        }
    }

    public boolean verifyOtp(String email, String enteredOtp) {

        Optional<userEntity> optionalUser = userRepository.findByEmail(email);

        if (!optionalUser.isPresent()) {
            return false;
        }

        userEntity user = optionalUser.get();

        if (user.getOtp() == null) {
            return false;
        }

        if (!enteredOtp.equals(user.getOtp())) {
            return false;
        }

        if (user.getOtpGeneratedTime().isBefore(LocalDateTime.now().minusMinutes(5))) {
            return false; // OTP expired
        }

        return true;
    }

    public void resetPassword(String email, String newPassword) {

        Optional<userEntity> optionalUser = userRepository.findByEmail(email);

        if (optionalUser.isPresent()) {

            userEntity user = optionalUser.get();

            user.setPassword(newPassword); // Use BCrypt in production
            user.setOtp(null);
            user.setOtpGeneratedTime(null);

            userRepository.save(user);
        }
    }
}
