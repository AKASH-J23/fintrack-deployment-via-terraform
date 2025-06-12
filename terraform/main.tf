data "aws_vpc" "default_vpc" {
    default = true
}

module "key_pair_generation" {
    source = "./module/generate_key"
}

resource "aws_key_pair" "fin_track_keypair" {
    key_name = "fintrack"
    public_key = module.key_pair_generation.public_key
}

resource "aws_security_group" "my_security_group" {
    name = "fin_track_sg"
    vpc_id = data.aws_vpc.default_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule" {
    security_group_id = aws_security_group.my_security_group.id
    from_port = 5001
    to_port = 5001
    ip_protocol = "tcp"
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ssh_ingress" {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    security_group_id = aws_security_group.my_security_group.id
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "egress_rule" {
    security_group_id = aws_security_group.my_security_group.id
    ip_protocol = "-1"
    cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_instance" "fin_track_instance" {
    ami = "ami-0e35ddab05955cf57"
    instance_type = "t2.micro"
    key_name = aws_key_pair.fin_track_keypair.key_name
    vpc_security_group_ids  = [ aws_security_group.my_security_group.id ]
    user_data = file("./scripts/userdata.sh")

    depends_on = [ aws_security_group.my_security_group ]

    provisioner "local-exec" {
        command = "echo \"App running on port 5001\""
    }
}