output "dockerBuildServer-pub-ip" {
  value = [ "${aws_instance.web.*.tags.Name}","-->","${aws_instance.web.*.public_ip}"] 
#   value = ["${aws_instance.web.0.public_ip}"]
}

# output "dockerBuildServer--2-pub-ip" {
#   value = ["${aws_instance.web.1.public_ip}"]
# }