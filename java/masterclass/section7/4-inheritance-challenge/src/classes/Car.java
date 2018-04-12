 package classes;

public class Car extends Vehicle{
	private int wheels;
	private int doors;
	private int engine;
	private String make;

	///////////////////////
	// METHODS
	///////////////////////
	
	public void changeGears() {
		System.out.println("Car.changeGears() called");
	}

	public void steer() {
		System.out.println("Car.steer() called");
	}

	///////////////////////
	// OVERRIDES
	///////////////////////
	
	@Override
	public void move(int speed) {
		steer();
		super.move(speed);
	}

	@Override
	public void accelerate() {
		changeGears();
		super.accelerate();
	}

	@Override
	public void decelerate() {
		changeGears();
		super.decelerate();
	}

	///////////////////////
	// CONSTRUCTORS
	///////////////////////
	
	/**
	 *
	 */
	public Car() {
		this("Unknown Make");
	}

	/**
	 * @param make
	 */
	public Car(String make) {
		this(100, 4, 4, 1, make);
	}

	/**
	 * @param wheels
	 * @param doors
	 * @param engine
	 * @param make
	 */
	public Car(int topSpeed, int wheels, int doors, int engine, String make) {
		super(topSpeed, true, "Car");
		this.wheels = wheels;
		this.doors = doors;
		this.engine = engine;
		this.make = make;
	}



	///////////////////////
	//GETTERS
	///////////////////////


	/**
	 * @return the wheels
	 */
	public int getWheels() {
		return wheels;
	}

	/**
	 * @return the doors
	 */
	public int getDoors() {
		return doors;
	}

	/**
	 * @return the engine
	 */
	public int getEngine() {
		return engine;
	}

	/**
	 * @return the make
	 */
	public String getMake() {
		return make;
	}

}
