package linklists;

public class node<T extends Comparable<T>>{

	private T data;
	private node<T> nextNode;

	public node(T data){
		this.data = data;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public node<T> getNextNode() {
		return nextNode;
	}

	public void setNextNode(node<T> nextNode) {
		this.nextNode = nextNode;
	}

	@Override
	public String toString() {
		return this.data.toString();
	}
}
