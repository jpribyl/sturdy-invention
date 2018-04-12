package classes;

public class Fish extends Animal {
	private int gills;
	private int eyes;
	private int fins;

	/**
	 * @param name
	 * @param brain
	 * @param body
	 * @param size
	 * @param weight
	 */
	public Fish(String name, int size, int weight, int gills, int eyes, int fins) {
		super(name, 1, 1, size, weight);

		this.gills = gills;
		this.eyes = eyes;
		this.fins = fins;
	}

	private void rest() {
		
	}

	private void swim() {
		moveMuscles();
		moveBackFin();
		super.move(speed);
	}

	private void moveMuscles() {
		
	}

	private void moveBackFin() {
		
	}
}
