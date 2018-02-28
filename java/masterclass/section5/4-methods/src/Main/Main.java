package Main;

public class Main {

	public static void main(String[] args) {

		//java automatically creates parameters - you don't need to redeclare them
		calculatescore(800, 3, 200, true);
	}

	private static void calculatescore(
			int score, 
			int levelcomplete, 
			int bonus, 
			boolean gameover) {

		if (gameover == true) {

			//notice that we can create a variable inside the code block
			int finalscore = score + (levelcomplete * bonus);
			System.out.println("your final score was " + finalscore);
		}
	}
}
