module "template_files" {
    source = "hashicorp/dir/template"
    base_dir = "${path.module}/web"
}

# create a s3 bucket
resource "aws_s3_bucket" "hosting_bucket" {
    bucket = var.bucket_name

    tags={
        "Name": "Static Webiste Bucket"
        "Environment": "Dev"
    }

} 

resource "aws_s3_bucket_ownership_controls" "hosting_bucket_ownership" {
  bucket = aws_s3_bucket.hosting_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "hosting_bucket_access_block" {
  bucket = aws_s3_bucket.hosting_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "hosting_bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.hosting_bucket_ownership,
    aws_s3_bucket_public_access_block.hosting_bucket_access_block,
  ]

  bucket = aws_s3_bucket.hosting_bucket.id
  acl    = "public-read"
}


resource "aws_s3_bucket_policy" "hosting_bucket_policy" {
    bucket = aws_s3_bucket.hosting_bucket.id

    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::${var.bucket_name}/*"
            }
        ]
    })
}



resource "aws_s3_bucket_website_configuration" "hosting_bucket_website_configuration" {
  bucket = aws_s3_bucket.hosting_bucket.id

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



resource "aws_s3_object" "hosting_bucket_files" {
    bucket = aws_s3_bucket.hosting_bucket.id

    for_each = module.template_files.files

    key = each.key
    content_type = each.value.content_type

    source  = each.value.source_path
    content = each.value.content

    etag = each.value.digests.md5
}

