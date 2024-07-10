provider "aws" {
  access_key = "<YOUR_ACCESS_KEY>"
  secret_key = "<YOUR_SECRET_KEY>"
  region     = "us-east-1" 
  endpoint   = "https://s3.wasabisys.com"
}

# bucket
resource "aws_s3_bucket" "sales_data_bucket" {
  bucket = "sales-data-bucket"
}

resource "aws_s3_bucket" "marketing_data_bucket" {
  bucket = "marketing-data-bucket"
}

resource "aws_s3_bucket" "engineering_data_bucket" {
  bucket = "engineering-data-bucket"
}

resource "aws_s3_bucket" "finance_data_bucket" {
  bucket = "finance-data-bucket"
}

resource "aws_s3_bucket" "operations_data_bucket" {
  bucket = "operations-data-bucket"
}

# policy
resource "aws_iam_policy" "readonly_policy" {
  name        = "readonly-policy"
  description = "Read-only access to S3 buckets"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Resource = ["arn:aws:s3:::*"]
      }
    ]
  })
}

resource "aws_iam_policy" "readwrite_policy" {
  name        = "readwrite-policy"
  description = "Read-write access to S3 buckets"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:*"]
        Resource = ["arn:aws:s3:::*"]
      }
    ]
  })
}

# user and policy
resource "aws_iam_user" "alice" {
  name = "alice"
}

resource "aws_iam_user_policy_attachment" "alice_rw_sales" {
  user       = aws_iam_user.alice.name
  policy_arn = aws_iam_policy.readwrite_policy.arn
}

resource "aws_iam_user_policy_attachment" "alice_rw_marketing" {
  user       = aws_iam_user.alice.name
  policy_arn = aws_iam_policy.readwrite_policy.arn
}

resource "aws_iam_user_policy_attachment" "alice_ro_engineering" {
  user       = aws_iam_user.alice.name
  policy_arn = aws_iam_policy.readonly_policy.arn
}

resource "aws_iam_user" "bob" {
  name = "bob"
}

resource "aws_iam_user_policy_attachment" "bob_rw_all" {
  user       = aws_iam_user.bob.name
  policy_arn = aws_iam_policy.readwrite_policy.arn
}

resource "aws_iam_user" "charlie" {
  name = "charlie"
}

resource "aws_iam_user_policy_attachment" "charlie_rw_operations" {
  user       = aws_iam_user.charlie.name
  policy_arn = aws_iam_policy.readwrite_policy.arn
}

resource "aws_iam_user_policy_attachment" "charlie_ro_finance" {
  user       = aws_iam_user.charlie.name
  policy_arn = aws_iam_policy.readonly_policy.arn
}

resource "aws_iam_user" "backup" {
  name = "backup"
}

resource "aws_iam_user_policy_attachment" "backup_ro_all" {
  user       = aws_iam_user.backup.name
  policy_arn = aws_iam_policy.readonly_policy.arn
}