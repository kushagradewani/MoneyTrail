package com.grownited.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.grownited.entity.userEntity;
import java.util.List;


@Repository
public interface UserRepository extends JpaRepository<userEntity, Integer>{

	Optional<userEntity> findByEmail(String email);
	
	List<userEntity> findByRole(String role);
	

	userEntity findByEmailAndPassword(String email, String password);
	
}
