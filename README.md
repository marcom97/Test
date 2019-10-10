# Test
A simple bash script for testing programs that write to stdout or stderr

### Basic Structure
The script allows multiple executables to be tested at the same time by following the structure outlined in this section. First, the script searches for tests inside of a directory named `tests`. This directory should be located in the same directory as the executables to be tested. The `tests` directory should contain directories with the same name as the executables you want to test. Tests for each program go in the directory that corresponds to its executable's name. These tests are simple text files that follow bash syntax. They specify the arguments and any input for stdin as well as the expected output from stdout and stderr.

**Example**: Directory structure for executables named "hello_stdin" and "hello_world"

* hello_stdin
* hello_world
* tests
  * hello_stdin
    * test_empty
    * test_not_empty
  * hello_world
    * test_no_args
    * test_one_arg
    
### Test Files
The test files are in fact bash scripts and each individual test can specify any of the three variables: `ARGS`, `STDIN`, or `EXPECT`. As their names suggest, they represent any arguments for the program, input for stdin, and the expected output (from stdout and stderr), respectively. If any of these aren't specified, their value will be set to `''` by default.

**Example**: “test_not_empty” (from the “hello_stdin” example)

~~~
STDIN=‘, how are you?’
EXPECT=‘Hello, how are you?’
~~~

**Example**: “test_one_arg” (from the “hello_world” example)

~~~
ARGS=‘world’
EXPECT=‘Too many arguments’
~~~

### Running Tests
To run the tests, the current directory must contain the `tests` directory as well as the executables to be tested. Then, simply run the script. The script will search `tests` and print the results from each test on the corresponding program. If any test fails, the program's output is provided along with the expected output.
