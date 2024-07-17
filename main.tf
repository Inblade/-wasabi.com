terraform {
  required_providers {
    wasabi = {
      source  = "thesisedu/wasabi"
      version = "4.1.9"
    }
  }
}

provider "wasabi" {
  key    = "<your-access-key>"
  secret = "<your-secret-key>"
  region = "us-east-1"
}

# Создание бакетов
resource "wasabi_bucket" "sales" {
  bucket = "sales-data-bucket"
}

resource "wasabi_bucket" "marketing" {
  bucket = "marketing-data-bucket"
}

resource "wasabi_bucket" "engineering" {
  bucket = "engineering-data-bucket"
}

resource "wasabi_bucket" "finance" {
  bucket = "finance-data-bucket"
}

resource "wasabi_bucket" "operations" {
  bucket = "operations-data-bucket"
}

# Политики доступа для каждого бакета
resource "wasabi_policy" "sales_readonly" {
  name = "sales-readonly-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::sales-data-bucket/*"
    }
  ]
}
POLICY
}

resource "wasabi_policy" "sales_readwrite" {
  name = "sales-readwrite-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::sales-data-bucket/*"
    }
  ]
}
POLICY
}

resource "wasabi_policy" "marketing_readonly" {
  name = "marketing-readonly-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::marketing-data-bucket/*"
    }
  ]
}
POLICY
}

resource "wasabi_policy" "marketing_readwrite" {
  name = "marketing-readwrite-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::marketing-data-bucket/*"
    }
  ]
}
POLICY
}

resource "wasabi_policy" "engineering_readonly" {
  name = "engineering-readonly-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::engineering-data-bucket/*"
    }
  ]
}
POLICY
}

resource "wasabi_policy" "engineering_readwrite" {
  name = "engineering-readwrite-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::engineering-data-bucket/*"
    }
  ]
}
POLICY
}

resource "wasabi_policy" "finance_readonly" {
  name = "finance-readonly-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::finance-data-bucket/*"
    }
  ]
}
POLICY
}

resource "wasabi_policy" "finance_readwrite" {
  name = "finance-readwrite-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::finance-data-bucket/*"
    }
  ]
}
POLICY
}

resource "wasabi_policy" "operations_readonly" {
  name = "operations-readonly-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::operations-data-bucket/*"
    }
  ]
}
POLICY
}

resource "wasabi_policy" "operations_readwrite" {
  name = "operations-readwrite-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::operations-data-bucket/*"
    }
  ]
}
POLICY
}

# Создание пользователей
resource "wasabi_user" "alice" {
  name = "alice"
}

resource "wasabi_user_policy_attachment" "alice_sales_rw" {
  user       = wasabi_user.alice.name
  policy_arn = wasabi_policy.sales_readwrite.arn
}

resource "wasabi_user_policy_attachment" "alice_marketing_rw" {
  user       = wasabi_user.alice.name
  policy_arn = wasabi_policy.marketing_readwrite.arn
}

resource "wasabi_user_policy_attachment" "alice_engineering_ro" {
  user       = wasabi_user.alice.name
  policy_arn = wasabi_policy.engineering_readonly.arn
}

resource "wasabi_user" "bob" {
  name = "bob"
}

resource "wasabi_user_policy_attachment" "bob_sales_rw" {
  user       = wasabi_user.bob.name
  policy_arn = wasabi_policy.sales_readwrite.arn
}

resource "wasabi_user_policy_attachment" "bob_marketing_rw" {
  user       = wasabi_user.bob.name
  policy_arn = wasabi_policy.marketing_readwrite.arn
}

resource "wasabi_user_policy_attachment" "bob_engineering_rw" {
  user       = wasabi_user.bob.name
  policy_arn = wasabi_policy.engineering_readwrite.arn
}

resource "wasabi_user_policy_attachment" "bob_finance_rw" {
  user       = wasabi_user.bob.name
  policy_arn = wasabi_policy.finance_readwrite.arn
}

resource "wasabi_user_policy_attachment" "bob_operations_rw" {
  user       = wasabi_user.bob.name
  policy_arn = wasabi_policy.operations_readwrite.arn
}

resource "wasabi_user" "charlie" {
  name = "charlie"
}

resource "wasabi_user_policy_attachment" "charlie_operations_rw" {
  user       = wasabi_user.charlie.name
  policy_arn = wasabi_policy.operations_readwrite.arn
}

resource "wasabi_user_policy_attachment" "charlie_finance_ro" {
  user       = wasabi_user.charlie.name
  policy_arn = wasabi_policy.finance_readonly.arn
}

resource "wasabi_user" "backup" {
  name = "backup"
}

resource "wasabi_user_policy_attachment" "backup_sales_ro" {
  user       = wasabi_user.backup.name
  policy_arn = wasabi_policy.sales_readonly.arn
}

resource "wasabi_user_policy_attachment" "backup_marketing_ro" {
  user       = wasabi_user.backup.name
  policy_arn = wasabi_policy.marketing_readonly.arn
}

resource "wasabi_user_policy_attachment" "backup_engineering_ro" {
  user       = wasabi_user.backup.name
  policy_arn = wasabi_policy.engineering_readonly.arn
}

resource "wasabi_user_policy_attachment" "backup_finance_ro" {
  user       = wasabi_user.backup.name
  policy_arn = wasabi_policy.finance_readonly.arn
}

resource "wasabi_user_policy_attachment" "backup_operations_ro" {
  user       = wasabi_user.backup.name
  policy_arn = wasabi_policy.operations_readonly.arn
}
