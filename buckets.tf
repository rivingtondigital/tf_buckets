# buckets.tf

resource "aws_s3_bucket" "my_bucket"{
  bucket        = var.bucket_name
  acl           = "private"
}

data "aws_iam_policy_document" "s3_access"{
  statement {
    actions     = ["s3:*"]
    resources   = [
                    "${aws_s3_bucket.my_bucket.arn}",
                    "${aws_s3_bucket.my_bucket.arn}/*"
                  ]
  }
}

resource "aws_iam_policy" "s3_policy"{
  name    = "${var.bucket_name}-policy"
  path    = "/"
  policy  = "${data.aws_iam_policy_document.s3_access.json}"
}

resource "aws_iam_role_policy_attachment" "s3_attach"{
  policy_arn  = aws_iam_policy.s3_policy.arn
  role        = var.role.name
}

