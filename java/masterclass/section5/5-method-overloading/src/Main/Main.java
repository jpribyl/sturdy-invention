package Main;

public class Main {
	public static void main(String[] args) {
		int newscore = calculatescore("tim", 500);
		System.out.println("new score is " + newscore);
		calculatescore(53);
		calculatescore();

		//testing the challenge code
		ftToCm(1,2);
		ftToCm(0,14);
		ftToCm(14);
		ftToCm(-4);
		
	}

	public static int calculatescore(String name, int score) {
		System.out.println("Player " + name + " scored " + score + " points");
		return score * 1000;
	}

	public static int calculatescore(int score) {
		System.out.println("Unnamed Player" + " scored " + score + " points");
		return score * 1000;
	}

	public static int calculatescore() {
		System.out.println("no player name or score given");
		return 0;
	}


	//Challenge
	//create a feet-and-inches-to-cm method
	//feet is 1st param
	//inches 2nd param
	//
	//validate both above zero, (else return -1)
	//
	//create another method with only inches as param
	
	private static double ftToCm(double feet, double inches) {
		if (feet < 0 || inches < 0) {
			//you could sout an error here
			System.out.println("bad input");
			return -1;
			
		} else {
			//you could sout the results here
			double cm = (12 * feet + inches) * 2.54;
			System.out.println(cm + " cm");
			return cm;
		}
	}

	private static double ftToCm(double inches) {
		int curFeet = (int) inches / 12;
		double remainIn = inches % 12;

		if (inches < 0) {
			System.out.println("bad input");
			return -1;
			
		} else {
			System.out.println(curFeet + " ft, " + remainIn + " in");
			return ftToCm(curFeet, remainIn);
		}
	}

}
