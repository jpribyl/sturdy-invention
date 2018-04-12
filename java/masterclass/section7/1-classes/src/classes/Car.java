package classes;

public class Car {
	private int wheels;
	private int doors;
	private String make;
	private String model;
	private String engine;
	private String color;

	public void setMake(String make) {
		String validMake = make.toLowerCase();

		if (validMake.equals("porsche") || validMake.equals("holden")) {
			this.make = make;
		} else {
			this.make = "unknown";
		}
	}

	public void setModel(String model) {
		this.model = model;
	}

	public String getModel() {
		return model;
	}

	public String getMake() {
		return make;
	}
}
