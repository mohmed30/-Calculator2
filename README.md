# -simple calculator 

this project is a simple calculator that perform basic mathmatic operations such as addition , subtraction, multiblication, division
the user will input the calculator in equation form eg. (2*6+6-4) and output the result


# cocept:
the idea of the program that it will read the equation from the user  and then waits for a addition or subtraction character  '+' , '-' 
then when the '+' or '-' is present the program will calculate whatever the operation behind the '+' or '-' character and store it then will do the same of whats after the sign and then excute the addition or subtraction.

# algorithm of the code 
 in the main process first the index of the stringin is stored in edx register and we store in ecx register max+1

which is equal to 101 then we call the irvine function  (readstring) which takes edx point to the input buffer and 

ecx is the maximum numper of the non null characthers and then it will store the size of the input string in eax register

then the process spiltbyadd is called. this function itrate on the stringin till it founds a + or - sign that when it will take

what ever was behind that sign lets say for example it was just a numper such as (5+...) or an operation like multiblication or divition 

such as (5*9*7+......) and this block will be stored in the array defind in memory (string1) so  string1 will have for the case mentioned
before (5*9*7). 

so after it reads the + or - sign   it will call the function (add_cont for + sign) or (sub_cont for - sign)  which will call (splitbymul) process and do the adding process 

the (splitbymul) process is responsible for doing the multiblication or the division behind or after each + or - sign 

then the result of that multiblication or division will be stored in the variable (res_mul). 

for the first time of the multiblication res_mul is put to 1  and multiblied by the first element and stored in res_mul 

so we basically move the first elemnt to res_mul. 

then we will go back again to take the second element and multbily it by the the first element. and the result is stored.

the same goes for the division. these can be found in the functions {div_cont},{mul_cont} . 

the functions {resetstring1 , resetstring2} used to empty both string1 and string2 to start a new operation. note that string 2 is reseted every multiblication or division operation. 
 
and string1 is resested after every addition or subtraction operation.

end_cont: this function is called when the string is empty so it calculates the final value of the equation 
end_cont2: when the string1 is empty this fumnction caluclates the final value of the multiblication or division.
after the the value of the whole equation is computed it will return to the main function and use the irvine function
(writeint) to display the output.
