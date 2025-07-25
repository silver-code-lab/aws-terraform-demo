output "instance_1_ip" {
  value = aws_instance.web1.public_ip
}

output "instance_2_ip" {
  value = aws_instance.web2.public_ip
}
