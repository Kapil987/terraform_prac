module "mywebserver" {
  source = "../7.modules/webserver"
  instance_type = "t2.small"
}

# module "mywebserver2" {
#   source = "../9.modules/webserver"
# }