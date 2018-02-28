package Main;

public class Main {
	public static void main(String[] args) {

		//operators are things like =, and +
		int result = 1 + 2;
		System.out.println("1 + 2 = " + result);

		int previousresult = result;
		
		//same syntax as python for this
		result -=1;
		System.out.println(previousresult + " - 1 = " + result);

		//we can start to build a manual loop if desired
		previousresult = result;
		result *= 10;
		System.out.println(previousresult + " * 10 = " + result);

		//and use it to investigate different operators
		previousresult = result;
		result /= 5;
		System.out.println(previousresult + " / 5 = " + result);

		//% is the mod operator and gives remainder
		previousresult = result;
		result %= 3;
		System.out.println(previousresult + " % 3 = " + result);

		//as in c, ++ is a shortcut for += 1 likewise, -- subtracts 1
		previousresult = result;
		result ++;
		System.out.println(previousresult + " + 1 = " + result);


		//we can use boolean with == in an if / else statement
		boolean isalien = true;
		if (isalien == false) {
			System.out.println("Not an alien");
		}
		else {
			System.out.println("An alien!");
		}


		//java uses all the standard operators like !=, >, <, &&, || etc
		if (result != 3) {
			System.out.println("result is not 3");
		}

		int topscore = 80;
		if (topscore < 100) {
			System.out.println("you got the top score");
		}

		//&& is the logical and operator
		int secondscore = 60;

		if ((topscore > secondscore) && (topscore < 100)) {
			System.out.println("top score is greater than second score and less than 100");
		}


		// || is the logical or operator
		if ((topscore > 90) || (secondscore <= 90)) {
			System.out.println("one of these tests is true");
		}

		int newvalue = 50;
		if (newvalue == 50) {
			System.out.println("this is true");
		}

		//this is tricky, inside the if, we are assigning the boolean to true
		boolean iscar = false;
		if (iscar = true) {
			System.out.println("iscar is: " + iscar);
			System.out.println("this shouldn't happen");
			
		}

		//this is a shortcut that means if iscar is true, then make
		//wascar true.. otherwise make it false
		boolean wascar = iscar ? true : false;
		System.out.println(wascar);
		


		//Challenge:
		//1. create double with value 20
		//2. create second double with value 80
		//3. add numbers and multiply by 25
		//4. find remainder of #3 when divided by 40
		//5. write an if statement that displays total over the limit if #4 >= 20
		double challengedouble = 20d;
		double seconddouble = 80d;

		//careful with precedence here
		double challengeresult = (seconddouble + challengedouble) * 25;
		System.out.println(challengeresult);

		double remainder = challengeresult % 40;
		System.out.println(remainder);

		if (remainder >= 20) {
			System.out.println("Total is over the limit.");
		}
	}
}
