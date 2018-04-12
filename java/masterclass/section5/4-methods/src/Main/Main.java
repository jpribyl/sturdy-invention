package Main;

public class Main {

	public static void main(String[] args) {

		//java automatically creates parameters - you don't need to redeclare them
		//we can treat the method call as the data type that it returns
		System.out.println("final score is: " + calculatescore(800, 3, 200, true));

		//so we can also give the return  )a variable
		int hiscore = calculatescore(3200, 3, 4, true); 

		//and then print the result
		System.out.println(hiscore);


		displayPosition("jcp", 1);
		System.out.println(calcHSPos(1500));
		System.out.println(calcHSPos(900));
		System.out.println(calcHSPos(400));
		System.out.println(calcHSPos(50));
		
	}

	//let's return the final score
	private static int calculatescore(
			int score, 
			int levelcomplete, 
			int bonus, 
			boolean gameover) {

		if (gameover == true) {

			//notice that we can create a variable inside the code block
			int finalscore = score + (levelcomplete * bonus);

			//we HAVE to return something, even if gaveover is false
			return finalscore;
		} else {
			//if game is not over, return -1 for final score
			return -1;
		}
	}

	//challenge: create method which takes in name, position in HScore
	//table outputs name and position
	
	//Second method which takes score, returns int 1,2,3, or 4 based on
	//input score
	private static void displayPosition(String name, int position) {
		System.out.println(name + " is in position " + position + " on the HS table");
	}

	private static int calcHSPos(int score) {
		if (score > 1000) {
			return 1;
		} else if (score > 500) {
			return 2;
		} else if (score > 100) {
			return 3;
		} else {
			return 4;
		}
	}
}
