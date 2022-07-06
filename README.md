Create an application for different operations with collections.

<b>First screen:</b> operations with array.

Generate an array of integers with 10_000_000 elements from 0 to 9_999_999 and display the execution time.

Operations to perform:

- insert at the beginning of an array 1000 elements (from 0 to 999 for example) one-by-one / at once;
- insert in the middle of an array 1000 elements one-by-one / at once;
- append to the end of an array 1000 elements one-by-one / at once;
- remove at the beginning 1000 elements one-by-one / at once;
- remove in the middle 1000 elements one-by-one / at once;
- remove at the end 1000 elements one-by-one / at once.

Display the execution time of each operation.

Add an activity indicator for each long-running operation.
  
![](https://github.com/roman-ivanoff/Collections/blob/main/1.gif)
  
<b>Second screen:</b> operations with set.

Add two text fields for user input and buttons for operations with sets.

Operations to perform:

- display all matching characters from text fields.
- display all characters that do not match in input fields.
- display all unique characters from the first text field that do not match in text fields.

![](https://github.com/roman-ivanoff/Collections/blob/main/2.gif)

<b>Third screen:</b> operations with a dictionary. 

Generate an array with 10_000_000 elements of improvised contact structs. String name and String phone.

Generate a dictionary with 10_000_000 elements of improvised contacts. Name as a key and phone as a value.

Operations on both collections:

- find the first element (“Name0”);
- find the last element (“Name9999999”);
- search for a non-existing element;

Display the execution time of each operation.

Add an activity indicator for long-running operations.
	
![](https://github.com/roman-ivanoff/Collections/blob/main/3.gif)


<b>Technology stack:</b>
- Swift
- UIKit
- Auto Layout
- Storyboard
- Xib
- GCD
- Collections
- XCTest
- MVC
