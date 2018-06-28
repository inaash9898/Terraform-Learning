#Varialbles

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "private_key_path" {}
variable "key_name" {
default = "testkey"

}

#Providers

provider "aws" {

access_key = "${var.aws_access_key}"
secret_key = "${var.aws_secret_key}"

region = "eu-west-1"

}

#Resources

resource "aws_instance" "nginx" {
ami = "ami-466768ac"
instance_type = "t2.micro"
key_name = "${var.key_name}"

Connection  {
user = "ec2_user"
private_key = "${file(var.private_key_path)}"
}

provisioner "remote-exec" {
inline = [
"sudo yum install nginx -y",
"sudo service nginx start"
]
}
}


#Output

output "aws_instance_public_dns" {
value = "${aws_instance.nginx.public_dns}"
}
