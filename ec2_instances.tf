resource "aws_instance" "task_1_instance" {
  ami           = "ami-09e6f87a47903347c"
  instance_type = "t2.micro"
}
