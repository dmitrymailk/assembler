#include <stdio.h>
#include <inttypes.h>

// assembler functions and variables
void calc_two_numbers_expression();
extern int64_t number_1;
extern int64_t number_2;
extern int64_t result;
int main()
{
  // expression: a*3 + b^2
  // --- EXAMPLE ONE ---
  // predefined values
  int64_t *num_1 = &number_1;
  int64_t *num_2 = &number_2;
  *num_1 = (int64_t)2;
  *num_2 = (int64_t)40;
  // assembler func
  calc_two_numbers_expression();
  printf("Output from printf = %ld\n", result); // 1606

  // --- EXAMPLE TWO ---
  // scan numbers
  scanf("%ld", &number_1);
  scanf("%ld", &number_2);
  calc_two_numbers_expression();
  printf("Output from printf = %ld\n", result);
  return 0;
}