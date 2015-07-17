#include <stdio.h>
#include <string.h>

struct tagTest
{
  char a;
  int b;
} work;

int main(void)
{
  int i;

  bzero(&work, sizeof(work));
  work.a = -1;
  work.b = -1;

  for(i=0;i<sizeof(work);i++)
    printf("%02x",*((unsigned char *)&work + i));
  return 0;
}
