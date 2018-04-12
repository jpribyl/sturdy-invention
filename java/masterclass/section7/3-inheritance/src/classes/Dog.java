package classes;

//when we call dog, we also need to call the animal constructor!
//all methods available to the Animal class will also be available to dogs
public class Dog extends Animal {

	// some characteristics of a dog, in addition to the animal characteristics
	private int eyes;
	private int legs;
	private int tail;
	private int teeth;
	private String coat;

	private void chew() {
		System.out.println("Dog.chew() called");
	}

	//////////////////////////////
	//METHODS
	//////////////////////////////
	public void walk() {
		System.out.println("Dog.walk() called");

		//bypassing the Dog.move() method
		super.move(5);
	}

	public void run() {
		System.out.println("Dog.run() called");

		//using the Dog.move() method
		move(10);
	}

	public void moveLegs(int speed) {
		System.out.println("Dog.moveLegs() called");
	}

	

	//////////////////////////////
	// CONSTRUCTORS
	//////////////////////////////
	/**
	 * @param name
	 * @param brain
	 * @param body
	 * @param size
	 * @param weight
	 */
	public Dog(String name, int size, int weight, int eyes, int legs, int tail, int teeth, String coat) {
		// super will call the constructor for the class that we are extending
		// IE initialize the animal class, but then add more features to the dog
		super(name, 1, 1, size, weight);
		this.eyes = eyes;
		this.legs = legs;
		this.tail = tail;
		this.teeth = teeth;
		this.coat = coat;
	}


	//////////////////////////////
	//OVERRIDES
	//////////////////////////////

	@Override
	public void eat() {
		// TODO Auto-generated method stub
		System.out.println("Dog.eat() called");
		chew();

		//this means call the super class method AS WELL
		super.eat();
	}

	@Override
	public void move(int speed) {
		// TODO Auto-generated method stub
		System.out.println("Dog.move() called");
		moveLegs(speed);
		super.move(speed);
	}

}
