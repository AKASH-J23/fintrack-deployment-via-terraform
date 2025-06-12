resource "tls_private_key" "private_key" {
        algorithm = "RSA"
        rsa_bits = 4096
        lifecycle {
                prevent_destroy = true
        }
}

resource "local_file" "generate_ssh_key" {
        filename = "${abspath(path.root)}/key.pem"
        content = tls_private_key.private_key.private_key_pem
        file_permission = "0400"

        lifecycle {
                prevent_destroy = true
        }
}

resource "local_file" "public_key" {
        filename = "${abspath(path.root)}/key.pub"
        content = tls_private_key.private_key.public_key_openssh
        file_permission = "0400"

        lifecycle {
                prevent_destroy = true
        }
}