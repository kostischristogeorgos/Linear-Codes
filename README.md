# Linear-Codes
A simple script that encodes and decodes messages built in SageMath implemented by a linear/hamming code
The script takes a message to decode. It is then randomly producing a generator matrix of the linear code of size (n,k). The message is split into a string of its ascii binary values for every character and then it adds the binary size of the original message's length to the left of the string 4 times to be used as a terminating value. Then, every n characters, these characters are encoded using the .encode() function of SageMath using a linear code and this output is then encoded again using another linear code. An error is randomly added, essentially turning a bit into its opposite value in order for the decode_to_message() function to decode the message. After this procedure has happened for all the n-characters, the finally decoded string is printed in the console, effectively implementing a linear-code's function. 
The Description.pdf file is written in Greek-I will add an english version as well
