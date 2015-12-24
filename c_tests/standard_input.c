#include <stdio.h>

int main(void)
{
  char s[11];  /* 文字数 + 1 のサイズ */

  printf( "10文字以内で入力して下さい\n" );
  printf( "ENTERキーで確定します\n" );

  gets( s );
  printf( "受け取った文字列 : %s\n", s );

  return 0;
}
