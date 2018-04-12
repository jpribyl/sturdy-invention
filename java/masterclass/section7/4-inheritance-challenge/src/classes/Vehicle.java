package classes;

public class Vehicle {
	private int topSpeed;
	private boolean operator;
	private String name;

	///////////////////////
	// METHODS
	///////////////////////
	
	public void move(int speed) {
		System.out.println("Vehicle.move() called -- speed is: " + speed);
	}

	public void accelerate() {
		System.out.println("Vehicle.accelerate() called");
	}

	public void decelerate() {
		System.out.println("Vehicle.decelerate() called");
	}



	///////////////////////
	// CONSTRUCTORS
	///////////////////////

	/**
	 *
	 */
	public Vehicle() {
		this("NoName");

	}

	/**
	 * @param name
	 */
	public Vehicle(String name) {
		this(0, true, name);
	}

	/**
	 * @param topSpeed
	 * @param operator
	 * @param name
	 */
	public Vehicle(int topSpeed, boolean operator, String name) {
		this.topSpeed = topSpeed;
		this.operator = operator;
		this.name = name;
	}

	///////////////////////
	// GETTERS
	///////////////////////

	/**
	 * @return the topSpeed
	 */
	public int getTopSpeed() {
		return topSpeed;
	}

	/**
	 * @return the operator
	 */
	public boolean getOperator() {
		return operator;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

}
