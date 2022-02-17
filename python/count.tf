variable "list1"{
    type = map
    default = {
        "ma" = "Java"
        "sec" = "Python"
    }
}

resource "random_pet" "pets"{
    length = length(each.key)
    prefix = each.value
    for_each = var.list1
    
    
}
