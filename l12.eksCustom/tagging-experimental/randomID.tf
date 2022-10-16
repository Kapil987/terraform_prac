# ASG ec2 names cannot be randomise becuase once terraform creates its at aws level
# resource "random_id" "ec2-unique-name" {
#   byte_length = 3
# }