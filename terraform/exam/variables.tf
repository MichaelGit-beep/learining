variable "number" {
    type = number
    default = 200
    sensitive = true
}
variable "string" {
    type = string
    default = "ami1, ami2, ami3, ami4, ami5"
}
variable "set_string" {
    type = set(string)
    default = ["a", "b", "c", "d", "e", "f"]
}

variable "set_number" {
    type = set(number)
    default = [100, 200, 300, 400, 500]
}

variable "list_string" {
    type = list(string)
    default = ["a", "b", "c", "d", "e", "f"]
}

variable "map1"{
    type = map
    default = {
        "key1" = "value1"
        "key2" = "value2"
    }
    sensitive = true
}