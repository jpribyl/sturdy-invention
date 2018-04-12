package classes;

public class Main {
	public static void main(String[] args) {

		Vehicle vehicle = new Vehicle(600, true, "Airplane");

		Car car = new Car();
		car.accelerate();
		car.move(10);

	}
}
