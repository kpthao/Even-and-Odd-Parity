# Hamming Code Bit Manipulation

## Part 1

This program is written in the MIPS assembly language and is used to perform error detection and correction on a number entered by the user. The user is prompted to enter a number between 0-255, and the program then converts that number to hexadecimal notation.

The program then performs a series of bit manipulation operations to add four parity bits to the number. These parity bits are used to detect and correct errors that may occur during data transmission or storage. The program uses bit shifting and masking operations to manipulate the bits of the number, and it also uses loops to count the number of 1s in each group of bits.

After the parity bits have been added, the program compares the parity bits to the original number to ensure that there are an even number of 1s in each group. If the parity is odd, the program adjusts the parity bits to make them even. The program then outputs the result of the number in hexadecimal notation, including the parity bits.

## Part 2

This program is written in the MIPS assembly language and is used to check the validity of a 12-bit Hamming code entered by the user. The user is prompted to enter a value between 0-4095, which is then interpreted as a 12-bit Hamming code.

The program then performs a series of bit manipulation operations to check the parity of each of the four parity bits in the code. The program uses bit shifting and masking operations to manipulate the bits of the code, and it also uses loops to count the number of 1s in each group of bits. If the parity of any of the bits is incorrect, the program calculates the correct Hamming code and outputs it to the user. If the parity of all bits is correct, the program ends.
