# create a s3 bucket
resource "aws_s3_bucket" "website-bucket"{
    bucket=var.bucket_name
    tags={
        "Name": "Static Webiste Bucket"
        "Environment": "Dev"
    }

} 

resource "aws_s3_bucket_ownership_controls" "bucket-ownership" {
  bucket = aws_s3_bucket.website-bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "bucket-access-block" {
  bucket = aws_s3_bucket.website-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "website-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket-ownership,
    aws_s3_bucket_public_access_block.bucket-access-block,
  ]

  bucket = aws_s3_bucket.website-bucket.id
  acl    = "public-read"
}



resource "aws_s3_bucket_website_configuration" "website-configuration" {
  bucket = aws_s3_bucket.website-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}


resource "aws_s3_object" "index"{
    bucket = aws_s3_bucket.website-bucket.id
    key="index.html"
    source="index.html"
    acl="public-read"
    content_type="text/html"
}


resource "aws_s3_object" "error"{
    bucket = aws_s3_bucket.website-bucket.id
    key="error.html"
    source="error.html"
    acl="public-read"
    content_type="text/html"
}


resource "aws_s3_object" "css"{
    bucket = aws_s3_bucket.website-bucket.id
    key="style.css"
    source="style.css"
    acl="public-read"
    content_type="text/css"
}