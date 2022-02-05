file("D:\\file.txt") - will return content of the file

length(var.var1) - will return number represent length of some variable 

## Numeric Functions: 
>max(1,2,3) - return the maximum number 
max(var.set1...)

>min(1,2,3) - return the min number 
min(var.set1...)

>ceil(10.1) = 11

>floor(10.9) = 10

## String Functions:
>split(",", "val1,val2") = will return a list from string delimiters by specified delimiter
split(",", var.string)

>lower(var.string) - will convert string to lower case

>upper(var.string) - will convert string to upper case

>title(var.string) - will convert string to title case

>substr(var.string, 0,7) - cut the string by specify start and end index

>join(",", ["ami1", "ami2", "ami3", "ami4", "ami5"]) - will create the string from list

## Collection Functions: 
> index(var.list_string, "c") - return the index of the value within the list

> element(var.list_string, 1) - return the element from the list or tuple by index

>toset(["val1", "val2", "val3", "val1"]) - will return the set, to use with for_each meta argument, as example 

>contains(var.list_string, "c") - return bool value if specific item is present 

### Map func:
>keys(var.somemap) - create a list from the keys of the map

>values(var.somemap) - create a list from the values of the map

>lookup(var.somemap, "somekey") - return the value from the map for specific key

