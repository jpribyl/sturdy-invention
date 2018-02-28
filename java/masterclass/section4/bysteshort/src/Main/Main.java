package Main;

public class Main {
	public static void main(String[] args) {

		//these are literals - IE they are just a number (not an expression)
		//this is the maximum and minimum integer allowed by the data type
		int maxint = 2_147_483_647;
		//we can use underscores like commas to make it more readable
		int minint = -2147483648;


		//width of 8
		byte minbyte = -128;

		//a width of 16
		short maxshort = 32767;

		//width of 64, you put an L after it so that you can store 2^63
		long mylong = 100L;
		
		
		//java has converted the literal into a byte!
		//so, we need to cast mybyte as a byte
		byte mynewbyte = (byte) (minbyte / 2);


		//by default, java assumes int - so we don't need to cast it here
		int mynewint = minbyte / 2;

		//but we do need to cast for short - notice that we can mix types!
		short mynewshort = (short) (mylong - maxshort);
		
		
		


		System.out.println(maxint);
		System.out.println(minint);
		System.out.println(minbyte);
		System.out.println(maxshort);
		System.out.println(mylong);
		System.out.println(mynewbyte);
		System.out.println(mynewint);
		System.out.println(mynewshort);
		
		
		
	}
}
