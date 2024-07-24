terraform {
  backend "s3" {
    bucket         = "jt-kcvpc-bucket"
    key            = "terraform-state-dir/terraform.tfstate"
    region         = "eu-west-1"
    profile        = "jtbaba"
    dynamodb_table = "dynamo-table-kcvpc"
  }
}
