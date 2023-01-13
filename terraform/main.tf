# module "moda" {
#     source = "./modules/modulea"
#     pet1 = "ImportedA"
# }

# output "moda_out" {
#     value = module.moda.pet1_id
# }
variable "var1" {
    type = string
    default = "win"
}

resource "random_pet" "p1" {
    prefix = var.var1 == "win" ? var.var1 : "lin"
}