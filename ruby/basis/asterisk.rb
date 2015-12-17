def return_array
  [1,2,3]
end


#*asteriskで配列を分解
a,b,c = *return_array
puts b


#asteriskで受けとる要素数が自由
def receive_array(*arr)
  puts arr[1]
end


receive_array(1,2,3)
receive_array('a','b','c')
