#include <stdio.h>
#include <stdint.h>

// Name: Yossi Heifetz

/*
    How to run:
    I used the gcc compiler - 
    PS> gcc -o program riddle3.c
    PS> ./program 
*/

// Equivalent to sub_401060
int collatz_steps(int n) {
    int iterations = 0;

    while (n != 1) {
        // Check if the number is even
        if ((n & 0x80000001) == 0) {
            // Arithmetic right shift logic, handles negative numbers too
            n = n / 2;
        } else {
            // Odd: multiply by 3 and add 1
            n = n * 3 + 1;
        }

        iterations++;
        printf("%d iteration: %d\n", iterations, n);
    }

    return iterations;
}

// Equivalent to _main
int main(int argc, char **argv, char **envp) {
    int input = 0;
    int result = 0;

    // Read an integer from the user (scanf("%d", &input))
    scanf("%d", &input);

    // Apply Collatz-like function
    result = collatz_steps(input);

    // Print the final result
    printf("Num %d took total %d iterations\n", input, result);

    return 0;
}
