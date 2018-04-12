package Main;

public class Main {
	public static void main(String[] args) {
		System.out.println("hello");

		// let's say we want to compare a few different interest rates
		System.out.println(calculateinterest(10000, 2));
		System.out.println(calculateinterest(10000, 5));
		System.out.println(calculateinterest(10000, 10));
		System.out.println(calculateinterest(10000, 12));

		// if we want to know lots of different interest rates - we should use a loop!
		for (int i = 0; i < 5; ++i) {
			System.out.println("with a rate of " + i + "% you'll make $" + calculateinterest(10000, i));
			// we can also format the output with String.format()
			System.out.println(
					"with a rate of " + i + "% you'll make $" + String.format("%.2f", calculateinterest(10000, i)));
		}

		// we can also run a for loop backwards
		for (int i = 8; i >= 2; --i) {
			System.out.println("with a rate of " + i + "% you'll make $" + calculateinterest(10000, i));
			System.out.println(
					"with a rate of " + i + "% you'll make $" + String.format("%.2f", calculateinterest(10000, i)));
		}

		// and for the challenge we can check the primeness of a range of numbers
		// this will exit as soon as it finds 3 primes.
		primesInRange(1, 100);
	}

	private static double calculateinterest(double amount, double interestrate) {
		return (amount * (interestrate / 100));
	}

	private static boolean isprime(int n) {
		if (n == 1 || n == 2) {
			return true;
		}
		for (int i = 2; i <= Math.sqrt(n); ++i) {
			if (n % i == 0) {
				return false;
			}
		}
		return true;
	}

	// Challenge, for statment using any range of numbers
	// determine if number is prime
	// if prime, print and increment a count of total primes in range
	// if count is 3, exit loop
	private static void primesInRange(int low, int hi) {
		int totalPrimeCount = 0;

		for (int i = low; i <= hi; ++i) {
			if (isprime(i)) {
				System.out.println(i + " is prime");
				totalPrimeCount += 1;

				if (totalPrimeCount == 3) {
					break;
				}
			}
		}
	}
}
