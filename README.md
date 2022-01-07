# - Simple Calculator 

This project is a simple calculator that perform basic mathematic operations such as addition , subtraction, multiplication and division.
The user will input the calculator in equation form eg. (2*6+6-4) and output the result


# - Concept

The idea of the program that it will read the equation from the user  and then waits for an addition or subtraction character  '+' , '-' 
then when the '+' or '-' is present the program will calculate whatever the operation behind the '+' or '-' character and store it then will do the same of whats after the sign and then excute the addition or subtraction.

# - Algorithm of the code 

In the main process first the index of the stringin is stored in edx register and we store in ecx register max+1
which is equal to 101 then we call the irvine function  (readstring) which takes edx point to the input buffer and 
ecx is the maximum numper of the non null characthers and then it will store the size of the input string in eax register.

Then the process spiltbyadd is called. This function itrate on the stringin till it founds a + or - sign that when it will take
what ever was behind that sign lets say for example it was just a number such as (5+...) or an operation like multiplication or division 
such as (5*9*7+......) and this block will be stored in the array defined in memory (string1) so string1 will have for the case mentioned
before (5*9*7). 

So after it reads the + or - sign it will call the function (add_cont for + sign) or (sub_cont for - sign)  which will call (splitbymul) process and do the adding process 

The (splitbymul) process is responsible for doing the multiPlication or the division behind or after each + or - sign 
then the result of that multiplication or division will be stored in the variable (res_mul). 

For the first time of the multiplication res_mul is put to 1 and multiplied by the first element and stored in res_mul 
So, we basically move the first element to res_mul. 
Then we will go back again to take the second element and multiply it by the the first element. and the result is stored.
The same goes for the division. these can be found in the functions {div_cont},{mul_cont} . 

The functions {resetstring1 , resetstring2} used to empty both string1 and string2 to start a new operation. note that string 2 is reseted every multiplication or division operation. 
And string1 is resested after every addition or subtraction operation.

end_cont: this function is called when the string is empty so it calculates the final value of the equation.

end_cont2: when the string1 is empty this function calculates the final value of the multiPlication or division.

After the the value of the whole equation is computed it will return to the main function and use the irvine function
(writeint) to display the output.


# - Results

![1](https://user-images.githubusercontent.com/96384738/148587558-1df5a339-0940-4068-8405-cbeb354063fc.jpeg)

![4](https://user-images.githubusercontent.com/96384738/148587635-60f01465-6a1e-4aad-91f0-f17707179acf.jpeg)


# - Code Limitations

1) Multiplying 2 negative numbers.

![2](https://user-images.githubusercontent.com/96384738/148587839-d2c1e622-4ce8-44b0-b3ef-0b0b1c64f948.jpeg)

2) Displaying fractions.

![3](https://user-images.githubusercontent.com/96384738/148588185-d27d8b3f-aca1-4f03-bbd7-6d736cbf830d.jpeg)


# - Team members

* Ziad Soliman Mohamed (zeyad170365@feng.bu.edu.eg)
* Marco George Adly (marco172077@feng.bu.edu.eg)
* Mohamed Ahmed Mohamed (mohamed170640@feng.bu.edu.eg)
* Mohamed Reda Mohamed (mohamed170685@feng.bu.edu.eg)
* Mohamed Hany Hassan (mohamed170779@feng.bu.edu.eg)

### Under supervision of **Dr. Abdelhamid Attaby**

