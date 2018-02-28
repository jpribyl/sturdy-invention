package Main;

public class Main {
	public static void main(String[] args) {
		int myint = 5;
		//by default java assumes x.x is a double, not float
		//we can cast it with (float) or we can put f at the end
		float myfloat = 5.4f;
		//default java type
		double mydouble = 5d;
		System.out.println(myint);
		System.out.println(myfloat);
		System.out.println(mydouble);


		int intdivision = 5 / 2;
		float floatdivision = 5f / 3;
		System.out.println(intdivision);
		System.out.println(floatdivision);


		/*
		 *Challenge: convert pounds to kg
		 *1. create variable to store #lbs
		 *2. calc # kg for number above and store that
		 *3. print the result
		 */
		double pounds = 200;
		double kg = pounds * .45359237;
		System.out.println(kg);
		
		
		
		
		
		
		
	}
}
