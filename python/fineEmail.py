# Enter your code here. Read input from STDIN. Print output to STDOUT

from email.utils import parseaddr
import re
import sys

def read_input_lines():
    input_lines = []
    try:
        while True:
            line = input()  # Read a line of input from STDIN
            input_lines.append(line)  # Append the line to the list
    except EOFError:
        pass  # End of file (EOF) reached

    return input_lines

def is_valid_email(email):
    address = parseaddr(email)
    if not address[1]:
        return False
    # Regular expression pattern for validating email addresses
    pattern = r'\b^[A-Za-z][A-Za-z0-9._%+-]+@[A-Za-z]+\.[A-Z|a-z]{1,3}$\b'
    return re.match(pattern, address[1]) is not None

for email in read_input_lines():
    if (is_valid_email(email)):
        print(email)
