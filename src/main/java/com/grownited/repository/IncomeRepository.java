package com.grownited.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.IncomeEntity;

@Repository
public interface IncomeRepository extends JpaRepository<IncomeEntity, Integer> {
	
	 @Query("SELECT SUM(i.amount) FROM IncomeEntity i")
	 Double totalIncome();

	 List<IncomeEntity> findByUserId(Integer userId);
	 
	// Total income for user in a specific month
	    @Query("SELECT SUM(i.amount) FROM IncomeEntity i " +
	           "WHERE i.userId = :userId AND MONTH(i.date) = :month AND YEAR(i.date) = :year")
	    Double totalIncomeByUserAndMonth(@Param("userId") Integer userId,
	                                     @Param("month") int month,
	                                     @Param("year") int year);

	    // Total income for user in a specific quarter
	    @Query("SELECT SUM(i.amount) FROM IncomeEntity i " +
	           "WHERE i.userId = :userId AND FUNCTION('QUARTER', i.date) = :quarter AND YEAR(i.date) = :year")
	    Double totalIncomeByUserAndQuarter(@Param("userId") Integer userId,
	                                       @Param("quarter") int quarter,
	                                       @Param("year") int year);
	    
}
