# data "local_file" "existed_1" {
#   filename = "f:\\created_file.txt"
#   depends_on = [
#     random_pet.pet1
#   ]
# }

# resource "random_pet" "pet"{
#   length = 1
#   prefix = data.local_file.existed_1.filename
# }

resource "random_pet" "pet1"{
  length = 1
  prefix = var.var1
}

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

