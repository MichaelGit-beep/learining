module "moda" {
    source = "./modules/modulea"
    pet1 = "ImportedA"
}

output "moda_out" {
    value = module.moda.pet1_id
}
