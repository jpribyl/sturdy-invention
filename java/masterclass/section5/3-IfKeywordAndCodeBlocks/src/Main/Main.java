package Main;

public class Main {
	public static void main(String[] args) {
		//but we can't access the variable out here - this gives an error:
		//System.out.println(finalscore);


		//challenge: print a second score with:
		//score = 10000
		//levelcomplete = 8
		//bonus = 200
		//still display the first score
		
		
		//might as well do this with a method
		Main.printscore(5000, 5, 200, true);
		Main.printscore(10000, 8, 200, true);
		
	}
	

	//if it's not static we'll have to instantiate the class
	private static void printscore(
			int score, 
			int levelcomplete, 
			int bonus, 
			boolean gameover) {

		if (score < 5000 && score > 1000) {
			System.out.println("score less than 5000, but greater than 1000");
		} else if (score < 1000) {
			System.out.println("score less than 1000");
		} else {
			System.out.println("score was at least 5000");
		}

		if (gameover == true) {

			//notice that we can create a variable inside the code block
			int finalscore = score + (levelcomplete * bonus);
			System.out.println("your final score was " + finalscore);
		}
	}
}
