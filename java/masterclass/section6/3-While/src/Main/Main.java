package Main;

public class Main {
	public static void main(String[] args) {
		whileTest();
		evenNums(4, 20);

	}

	// here are a couple of simple while implementations
	private static void whileTest() {
		int count = 1;

		while (count != 6) {
			System.out.println("count value is " + count);
			count++;
		}

		while (true) {
			if (count == 9) {
				break;
			}
			System.out.println("count is now " + count);
			count++;
		}

		// and a do while
		do {
			System.out.println("count value " + count);
			count++;
		} while (count != 12);
	}

	// challenge - make a method that takes an int in
	// -return true if int in is even
	// -else false
	private static boolean isEven(int i) {
		if (i % 2 == 0) {
			// System.out.println(i + " is even");
			return true;
		} else {
			// System.out.println(i + " is not even");
			return false;
		}
	}

	private static void evenNums(int number, int finishnum) {
		int count = 0;

		// check the start condition
		if (isEven(number)) {
			count++;
			System.out.println(number + " is even");
		}

		// this while loop will pick out all the even numbers in a range.
		// continue will cause the loop to return to the top.
		while (number < finishnum) {

			// this causes us to begin with num + 1
			// if this is after the continue, we will never increment
			// and then we would have an infinite loop
			number++;
			if (count == 5) {
				break;
			}

			if (!isEven(number)) {
				continue;
			}

			count++;
			System.out.println(number + " is even");
		}

		System.out.println(count + " even numbers found");
	}
}
