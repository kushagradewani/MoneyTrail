package com.grownited.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "account")
public class AccountEntity {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer inaccountId;
	private String title;
	private Boolean exDefault;
	private Float amount;
	private Integer userId;
	private Boolean active;
	
	public Integer getInaccountId() {
		return inaccountId;
	}
	public void setInaccountId(Integer inaccountId) {
		this.inaccountId = inaccountId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Boolean getExDefault() {
		return exDefault;
	}
	public void setExDefault(Boolean exDefault) {
		this.exDefault = exDefault;
	}
	public Float getAmount() {
		return amount;
	}
	public void setAmount(Float amount) {
		this.amount = amount;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Boolean getActive() {
		return active;
	}
	public void setActive(Boolean active) {
		this.active = active;
	}
	
	
	
	
}
