# Assembly-Password-Genrator
This repository contains an assembly language program that generates passwords of a specified length and complexity using Irvine32.inc. The password can include uppercase letters, lowercase letters, numbers, and special characters based on the specified complexity level.

## How It Works
The program uses the Irvine32 library to handle input and output operations. It reads two integers from the user: the desired length of the password and the complexity level. Based on the complexity level, it generates a random password using the specified character sets.

## Complexity Levels
- Uppercase letters only
- Mixed case (uppercase and lowercase letters)
- Mixed case with numbers (uppercase, lowercase letters, and numbers)
- All characters (uppercase, lowercase letters, numbers, and special characters)
## Usage
Assemble and link the program using an assembler that supports the Irvine32 library (such as MASM).
Run the executable.
Input the desired password length.
Input the desired complexity level (1-4).
The generated password will be displayed.
Code Structure
.data: Defines data storage for the password, length, complexity, and character sets.
start PROC: The main procedure that handles reading input, generating the password, and displaying the result.
GenerateRandomChar PROC: Generates a random character based on the specified complexity level.
