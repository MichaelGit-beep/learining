# variable "list1"{
#     type = map
#     default = {
#         "ma" = "Java"
#         "sec" = "Python"
#     }
# }


# resource "random_pet" "pets"{
#     length = length(each.key)
#     prefix = each.value
#     for_each = var.list1
    
    
#     provisioner "local-exec" {
#         command = "touch /d/Git/learning/terraform/exam/provisioned.${self.id}"    
#     } 
# }


variable "list1"{
    type = list
    default = ["one", "two"]
}

variable "contPorts" {
    type = map
    default = {
        port = 8080
        port1 = 9090
        port2 = 9191
    }
}


resource "random_pet" "pets" { 
    for_each = var.contPorts
    length = 1
    prefix = each.value
}