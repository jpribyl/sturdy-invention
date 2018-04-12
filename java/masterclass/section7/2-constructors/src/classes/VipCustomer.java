package classes;

//challenge
//3 constructors
//1 - empty calls constructor 3 with defaults
//2 - specifies the values it receives and then a default for the 3rd
//3 - saves all fields
public class VipCustomer {
	private double creditLimit;
	private String name;
	private String email;

	//////////////////////
	//CONSTRUCTORS
	//////////////////////
	/**
	 *
	 */
	public VipCustomer() {
		this(1200, "NoName", "NoEmail");
	}

	/**
	 * @param name
	 * @param email
	 */
	public VipCustomer(String name, String email) {
		this(1200, name, email);
	}

	/**
	 * @param creditLimit
	 * @param name
	 * @param email
	 */
	public VipCustomer(double creditLimit, String name, String email) {
		this.creditLimit = creditLimit;
		this.name = name;
		this.email = email;
	}

	//////////////////////
	//GETTERS
	//////////////////////
	/**
	 * @return the creditLimit
	 */
	public double getCreditLimit() {
		return creditLimit;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

}
