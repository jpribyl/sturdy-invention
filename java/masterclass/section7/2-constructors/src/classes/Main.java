package classes;

public class Main {
	public static void main(String[] args) {

		// this goes with the bank account challenge exercise
		BankAccount jskrilla = new BankAccount(12345, 420.00, "jskrilla");

		jskrilla.deposit(100);
		jskrilla.withdraw(518.99);
		jskrilla.withdraw(10);

		BankAccount defaults = new BankAccount();
		System.out.println("the default account number is: " + defaults.getAccountNum());

		BankAccount specified_acctNum = new BankAccount(99999);
		System.out.println("the default balance is: " + specified_acctNum.getBalance());

		VipCustomer importantGuy = new VipCustomer();
		System.out.println(importantGuy.getCreditLimit());
		System.out.println(importantGuy.getEmail());
	}
}
