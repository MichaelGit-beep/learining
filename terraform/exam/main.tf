# data "local_file" "existed_1" {
#   filename = "f:\\created_file.txt"
#   depends_on = [
#     random_pet.pet1
#   ]
# }
# 
# resource "random_pet" "pet"{
#   length = 1
#   prefix = data.local_file.existed_1.filename
# }
# 

# resource "local_file" "f1"{
#   content = "local_file-${random_pet.pet1.id}"
#   filename = "d:\\file.txt"
#   depends_on = [random_pet.pet1]
# }
# resource "local_file" "f12"{
#   content = "local_file-${random_pet.pet1.id}"
#   filename = "d:\\file1.txt"
#   depends_on = [random_pet.pet1]
# }

resource "random_password" "pass1"{
    length = var.number < 200 ? 1 : 100 
}

output "password"{
    value = random_password.pass1.result 
}

resource "random_pet" "pet1"{
  length = local.pet_lenght
  prefix = local.pet_prefix
}
 
locals {
    pet_prefix = "Mr"
    pet_lenght = 2
}
dynamic "ingress" {
     for_each = var.instances
     content {
         from_port = ingress.value
         to_port = ingress.value
     }
}