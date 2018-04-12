package classes;

public class Main {
	/**
	 *
	 *
	 * @param args
	 */
	public static void main(String[] args) {

		Animal animal = new Animal("Animal", 1, 1, 5, 5);
		Dog dog = new Dog("Yorkie", 8, 20, 2, 4, 1, 20, "long silky");

		// dogs also inherit the ability to eat! but, we can override the eat method
		// we see here, that by calling dog.eat() we are also calling dog.chew() and
		// animal.eat()
		dog.eat();

		// in the walk method - we use the super.move() method and by pass the
		// dog.move()
		dog.walk();

		// but in the run method - we use the dog.move() method in addition to the
		// super.move()
		dog.run();

		Fish fish = new Fish("fishy", 3, 4, 8, 2, 5);
		fish.getName();
		fish.move(6);
	}
}
