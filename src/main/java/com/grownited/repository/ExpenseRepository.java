package com.grownited.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.grownited.entity.ExpenseEntity;

@Repository
public interface ExpenseRepository extends JpaRepository<ExpenseEntity, Integer> {
	
	@Query("SELECT SUM(e.amount) FROM ExpenseEntity e")
    Double totalExpense();

    @Query("SELECT SUM(e.amount) FROM ExpenseEntity e WHERE DATE(e.date) = CURRENT_DATE")
    Double todayExpense();
    
    
    List<ExpenseEntity> findByUserId(Integer userId);
    
    // Total expense for user in a specific month
    @Query("SELECT SUM(e.amount) FROM ExpenseEntity e " +
           "WHERE e.userId = :userId AND MONTH(e.date) = :month AND YEAR(e.date) = :year")
    Double totalExpenseByUserAndMonth(@Param("userId") Integer userId,
                                      @Param("month") int month,
                                      @Param("year") int year);

    // Total expense for user in a specific quarter
    @Query("SELECT SUM(e.amount) FROM ExpenseEntity e " +
           "WHERE e.userId = :userId AND FUNCTION('QUARTER', e.date) = :quarter AND YEAR(e.date) = :year")
    Double totalExpenseByUserAndQuarter(@Param("userId") Integer userId,
                                        @Param("quarter") int quarter,
                                        @Param("year") int year);

}
