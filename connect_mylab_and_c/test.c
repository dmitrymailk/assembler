#include <stdio.h>
#include <inttypes.h>

void calc_two_numbers_expression();
extern int64_t number_1;
extern int64_t number_2;
extern int64_t result;
int main()
{
  int64_t *num_1 = &number_1;
  int64_t *num_2 = &number_2;
  *num_1 = (int64_t)2;
  *num_2 = (int64_t)40;
  calc_two_numbers_expression();
  printf("Output from printf = %ld\n", result);
  return 0;
}