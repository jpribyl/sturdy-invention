package Main;

public class Main {
	public static void main(String[] args) {

		int value = 3;
		if (value == 1) {
			System.out.println("value was 1");
		} else if (value == 2) {
			System.out.println("value was 2");
		} else {
			System.out.println("was not 1 or 2");
		}

		int switchvalue = 5;
		switch (switchvalue) {
		case 1:
			System.out.println("value was 1");
			break;
		case 2:
			System.out.println("value was 2");
			break;

		// case will also let you do some shorthand to test
		// several cases at once this functions like 3 || 4 || 5
		case 3:
		case 4:
		case 5:
			System.out.println("value was 3, or 4 or 5");
			break;

		default:
			System.out.println("was not 1 or 2");
			break;
		}

		// challenge:
		// new switch testing for a, b, c, d, e
		// display message if any of these found
		// default for none found
		char charvalue = 'f';

		switch (charvalue) {
		case 'a':
		case 'b':
		case 'c':
		case 'd':
		case 'e':
			System.out.println("Found " + charvalue);
			break;
		default:
			System.out.println("character not found");
		}

		String month = "JANuary";
		// string has a method to lower the case, just like .lower() in python
		switch (month.toLowerCase()) {

		case "january":
			System.out.println("Jan");
			break;

		case "june":
			System.out.println("Jun");
			break;

		}
	}
}
