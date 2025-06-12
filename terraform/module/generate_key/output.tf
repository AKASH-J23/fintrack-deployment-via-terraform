output "public_key" {
    value = tls_private_key.private_key.public_key_openssh
}