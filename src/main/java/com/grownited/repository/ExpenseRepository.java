package com.grownited.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.grownited.entity.ExpenseEntity;

@Repository
public interface ExpenseRepository extends JpaRepository<ExpenseEntity, Integer> {
	
	@Query("SELECT SUM(e.amount) FROM ExpenseEntity e")
    Double totalExpense();

    @Query("SELECT SUM(e.amount) FROM ExpenseEntity e WHERE DATE(e.date) = CURRENT_DATE")
    Double todayExpense();

}
