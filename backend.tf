terraform {
  backend "s3" {
    bucket         = "jt-kcvpc-bucket"
    key            = "terraform-state-dir/terraform.tfstate"
    region         = "us-east-1"
    profile        = "jtbaba"
    dynamodb_table = "dynamo-table-kcvpc"
  }
}
