output "public_page_url" {
  value = "http://${aws_s3_bucket_website_configuration.web_page_bucket.website_endpoint}"
}
