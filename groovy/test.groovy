def dict = [:]
dict[1] = "Hello"
dict[2] = "World"

// println "${dict}"
dict.each{
    key, value -> println "${key} \n${value}";
}
