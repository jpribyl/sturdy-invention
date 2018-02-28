package Main;

public class Main {
	public static void main(String[] args) {

		//so far we've looked at primitive types
		//technically a string is not a primitive, but it kind of is
		String mystring = "this is my string";
		System.out.println(mystring);

		//we can concat with the +
		mystring = mystring + " and some more string too!";
		System.out.println(mystring);

		//java will treat number strings as a string
		String numberstring = "250.55";
		numberstring = numberstring + "49.50";
		System.out.println(numberstring);

		String laststring = "10";
		int myint = 50;
		laststring = laststring + myint;

		//java will cast the int as a string (this can't go the other way round though)
		System.out.println(laststring);
		
		
		
		
	}
}
