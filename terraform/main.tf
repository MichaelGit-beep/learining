module "example_module" {
  source = "./modules/modulea"
}

output "frommodule" {
    value = module.example_module.pet1_id
}
output "frommodule2" {
    value = module.example_module.random_pet.pet1.id
}