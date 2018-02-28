package linklists;
//import java.util.*;

public class section3 {

    public static void main(String[] args) {
	    section3.linked_list_basics();
	    section3.linked_list_operations();

    }


    public static void linked_list_basics() {
	////////////////////////////
	// LINKED LIST THEORY
	////////////////////////////

	/*
	linked lists are nodes and references / pointers that go node to
	node.

	The last one is always null:
	
	node1 	  node2     node3     node4      null
	------    ------    ------    ------     ------
	|    |    |    |    |    |    |    |     |    |
	|    |--> |    |--> |    |--> |    |---> |    |
	------    ------    ------    ------     ------

	so, we can iterate until we hit something that is null.

	a single node can containn data.. int, float, double etc
	but it also contains a reference pointing to the next node

	linked lists are the basis to implement stacks and queues as well

	NO RANDOM ACCESS TO DATA


	the upshot is that they're DYNAMIC
	do not need to specify the size beforehand

	they grow organically O(1) for insertion or removal at the beginning of
	the list

	advantages:
		dynamic
		insertion / deletion from beginning
		organic growth
	
	disadvantages:
		reverse traversing is hard (requires second linked list backward)
		no random access (must be read from beginning)
		wasted memory
	*/
    }

    public static void linked_list_operations() {
	////////////////////////////////
	//LINKED LIST OPERATIONS
	////////////////////////////////

	/*
	Insertion at start -> O(1)

	algorithm: put value at start, put reference to the previously first
	number in the linked list


	Insertion at end -> O(N)

	algorithm: first we have to interate through the entire list, then we
	can insert an item at the end, add a reference to null, and update the
	(previously) last reference to point it at our new item.

	Note that insertion at the end is O(1) + O(N) = O(N) because the
	insertion once we traverse the list is O(1)

	Removal, very similar to insertion! O(1) at the beginning, O(N) at the
	end
	
	 */
    }

    public static void doubly_linked_lists(){
	////////////////////////////////
	//DOUBLY LINKED LISTS
	////////////////////////////////

	/*
	
	If we know that we will need to traverse a linked list backwards, we
	might benefit from adding a second linked list that traverses the
	opposite direction, but it takes some extra memory. this looks like:

	node1 	  node2     node3     node4      null
	------    ------    ------    ------     ------
	|    |<-- |    |<-- |    |<-- |    |<--- |    |
	|    |--> |    |--> |    |--> |    |---> |    |
	------    ------    ------    ------     ------

	*/
    }

    public static void linked_list_vs_arrays(){
	////////////////////////////////
	//LINKED LISTS VS ARRAYS
	////////////////////////////////
	/*
	

	1) search:
	LL will complete in O(N)
	AR will commplete in O(1) if the index is known or O(N) if not


	2) remove:
	LL will remove from beginning in O(1)
	AR will remove from end in O(1)

	LL will remove from end in O(N)
	AR will remove from beginning in O(N)


	3) memory:
	LL may require extra memory O(N)
	AR are memory friendly O(0)



	*/
    }

    public static void linked_list_implementation(){
	////////////////////////////////
	//IMPLEMENT LINKED LISTS
	////////////////////////////////
    }
}


class Node<T extends Comparable<T>>{

	private T data;

	private Node(T data){
		this.data = data;
	}
}
