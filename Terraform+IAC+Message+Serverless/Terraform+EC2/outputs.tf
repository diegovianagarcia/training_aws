output instance_id {
  value = aws_instance.bia_dev.id
}

output instance_type {
  value = aws_instance.bia_dev.instance_type
}

output instance_security_groups {
  value = aws_instance.bia_dev.security_groups
}
