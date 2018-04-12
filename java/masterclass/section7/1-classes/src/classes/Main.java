package classes;

public class Main {
	public static void main(String[] args) {
		Car porsche = new Car();
		Car holden = new Car();

		// after creating the validation, we cannot set the model to anything other than
		// a porsche or a holden - if we try to set it to a carrera then it won't work
		// and we'll return null
		porsche.setMake("carrera");
		System.out.println(porsche.getMake());
		porsche.setMake("porsche");
		System.out.println(porsche.getMake());

		holden.setModel("commodore");
		System.out.println(holden.getModel());
	}
}
