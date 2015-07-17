#include <stdio.h>
#include <linux/types.h>

int main()
{
  char fifo[] = {0x12, 0x34, 0xAB, 0xCD};
  __u32 val;
  val = *(__u32 *)fifo;
  printf("0x%Xｴn", val);
  return 0;
}
