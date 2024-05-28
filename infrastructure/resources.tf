resource "aws_s3_bucket" "page_bucket" {
  bucket = "public-page-680b3713"
  tags = {
    "Author" : "Bryan Solares",
    "Enviroment" : "Prod"
  }
}

resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.page_bucket.id
  key          = "index.html"
  source       = "../code/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.page_bucket.id
  key          = "error.html"
  source       = "../code/error.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "web_page_bucket" {
  bucket = aws_s3_bucket.page_bucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "public_read_access" {
  bucket = aws_s3_bucket.page_bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
    "Id": "Policy1713798336678",
  "Statement": [
    {
      "Sid": "AllowViewAccess",
      "Effect": "Allow",
	    "Principal": "*",
      "Action": [ "s3:GetObject" ],
      "Resource": [
        "${aws_s3_bucket.page_bucket.arn}",
        "${aws_s3_bucket.page_bucket.arn}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_s3_bucket_public_access_block" "public_access_acl" {
  bucket = aws_s3_bucket.page_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}





