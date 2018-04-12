package classes;

import java.text.*;

//challenge: new class bank account
//fields account number, balance, customer name, email, and phone
//
//getters and setters for each field
//2 additional methods
//1. deposit funds
//2. withdraw funds but only if they don't overdraw their account
public class BankAccount {
	private int accountNum;
	private double balance;
	private String name;
	private String email;
	private String phone;

	//////////////////////////
	//METHODS
	//////////////////////////
	public void deposit(double amount) {
		System.out.println(
				"old balance is " + 
				customFormat("$#.##", this.balance));

		this.balance += amount;

		System.out.println(
				"new balance is " + 
				customFormat("$#.##", this.balance));
	}


	public void withdraw(double amount) {

		if (this.balance >= amount) {
			System.out.println(
					"old balance is " + 
					customFormat("$#.##", this.balance));

			this.balance -= amount;

			System.out.println(
					"new balance is " + 
					customFormat("$#.##", this.balance));

		} else {
			System.out.println(
					"not enough in account to withdraw you only have: " + 
					customFormat("$#.##", this.balance));
		}
	}


	public static String customFormat(String pattern, double value) {
		DecimalFormat myFormatter = new DecimalFormat(pattern);
		String output = myFormatter.format(value);
		return output;
	}


	////////////////////////
	//CONSTRUCTORS
	////////////////////////


	/**
	 *
	 */
	public BankAccount() {
		//we can call another constructor to set default values
		this(12345, 0.00, "myacct");
	}


	/**
	 * @param accountNum
	 */
	public BankAccount(int accountNum) {
		//we can also specify some parameters and then call the main
		//constructor with the rest of the parameters
		this(accountNum, 0.00, "myacct"); 
	}


	/**
	 * @param accountNum
	 * @param balance
	 */
	public BankAccount(int accountNum, double balance) {
		this.accountNum = accountNum;
		this.balance = balance;
	}


	/**
	 * @param accountNum
	 * @param balance
	 * @param name
	 */
	public BankAccount(int accountNum, double balance, String name) {
		this.accountNum = accountNum;
		this.balance = balance;
		this.name = name;
	}


	/**
	 * @param accountNum
	 * @param balance
	 * @param name
	 * @param email
	 */
	public BankAccount(int accountNum, double balance, String name, String email) {
		this.accountNum = accountNum;
		this.balance = balance;
		this.name = name;
		this.email = email;
	}


	/**
	 * @param accountNum
	 * @param balance
	 * @param name
	 * @param email
	 * @param phone
	 */
	public BankAccount(int accountNum, double balance, String name, String email, String phone) {
		this.accountNum = accountNum;
		this.balance = balance;
		this.name = name;
		this.email = email;
		this.phone = phone;
	}


	////////////////////////////
	// GETTERS AND SETTERS
	////////////////////////////


	/**
	 * @return the accountNum
	 */
	public int getAccountNum() {
		return accountNum;
	}

	/**
	 * @param accountNum
	 *            the accountNum to set
	 */
	public void setAccountNum(int accountNum) {
		this.accountNum = accountNum;
	}

	/**
	 * @return the balance
	 */
	public double getBalance() {
		return balance;
	}

	/**
	 * @param balance
	 *            the balance to set
	 */
	public void setBalance(double balance) {
		this.balance = balance;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email
	 *            the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}

	/**
	 * @param phone
	 *            the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
	}

}
