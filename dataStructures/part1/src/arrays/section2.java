///////////////////////////////////
// ARRAYS
///////////////////////////////////

/*
 * Arrays have an index which starts at zero
 * They are RANDOM ACCESS
 * IE numbers[row][col] may operate in O(1)
 *
 * Adding to the end of an array is also O(1)
 * However, when we want to add to the middle of an arry, it will be O(N)
 * This is because we will have to shift the rest of the array.
 *
 *advantages:
 	easy to implement / use
	very fast when used correctly

disadvantages:
	need to know size before
	if full, it must be copied into a larger array
	reconstruction is O(N) not O(1)
	*/


///////////////////////////////////
// OPERATIONS
///////////////////////////////////


/*
 add(value) will add to the end, and is fast

 insert(index, value) will take linear time because we must shift the values

 remove(end) will be O(1)
 but,
 remove(middle) will be O(N) because you have to shift everything
 */




package arrays;
import java.util.*;

public class section2 {


    public static void main(String[] args) {

	section2.using_arrays();
	section2.using_array_lists();

    }


    public static void using_arrays() {

	///////////////////////////////////
	// USING ARRAYS
	///////////////////////////////////

	//let's start using them!

        // Prints "Hello, World" to the terminal window.
        System.out.println("Hello, World");
	int [] nums = new int[5];


	//assigns values to the array between 1 and 4
	//note that ++i will add 1 before doing any assignment
	for(int i=1;i<nums.length;++i)
	{
		System.out.println(i);
		nums[i] = i;
	}


	//O(1) random access index
	int num = nums[2];
	System.out.println(num);

	//O(N) linear search through the array
	for(int i=0;i<nums.length;++i)
		if(nums[i] == 4)
			System.out.println("index found, " + i);

	//we can take O(N) --> O(logN) with binary trees and -->O(1) with hashtables
    }

    public static void using_array_lists() {
	///////////////////////////////////
	// USING ARRAYLISTS
	///////////////////////////////////

	    /*
	     *We must define the capacity - IE how many things we think will be in
	     the array making a larger array when necessary with reduce the number
	     of reallocations.
	     */
	
	List<String> list = new java.util.ArrayList<>();

	list.add("adam");
	list.add("joe");
	list.add("kevin");

	//here, index 1 holds kevin
	System.out.println(list.get(1));

	//removal is slower but will still execute in O(N) time
	list.remove(0);

	//we can use get() for random access in O(1). Notice that index 1 was
	//shifted and now holds kevin
	System.out.println(list.get(1));

	//this is an enhanced for loop, the : may be read as 'in' this is not a
	//concept of slicing the way that python does
	for(String s : list)
		System.out.println(s);

    }
}

