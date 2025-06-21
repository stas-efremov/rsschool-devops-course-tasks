resource "aws_s3_bucket" "rs_devops_task1_s3_bucket" {
  bucket = "rs-devops-2025-task1-s3-bucket"

  tags = {
    Name = "S3 bucket for task 1"
  }
}
