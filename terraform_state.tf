/*Store Terraform state to s3*/
resource "aws_s3_bucket" "terraform-state" {
  bucket = "it-syndicate-terraform-state"
  acl    = "public-read-write"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

/*Locking table in DynamoDB
resource "aws_dynamodb_table" "terraform-locks" {
  name         = "it-syndicate-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID" 
  attribute {
    name = "LockID"
    type = "S"
  }
}
*/

/*Terraform backend configuration*/
terraform {
  backend "s3" {
    bucket         = "it-syndicate-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-central-1"
    /*dynamodb_table = "terraform-locks"*/
    encrypt        = true
  }
}