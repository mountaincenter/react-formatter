module "cloudfront" {
  source             = "./cloudfront"
  r_prefix           = var.r_prefix
  fqdn_name          = local.fqdn.web_name
  bucket_name        = local.bucket.name
  acm_certificate_id = module.acm_frontend.acm_certificate_id
}

module "acm_frontend" {
  source      = "./acm"
  domain_name = var.domain_name
  fqdn_name   = local.fqdn.web_name
  alias_name  = module.cloudfront.cloudfront_distribution_domain_name
  zone_id     = module.cloudfront.cloudfront_distribution_hosted_zone_id
  providers = {
    aws = aws.virginia
  }
}

# =================
# S3 Object Update
# =================
module "distribution_files" {
  source   = "hashicorp/dir/template"
  base_dir = "../frontend/react-app/build"
}

resource "aws_s3_object" "multiple_objects" {
  for_each     = module.distribution_files.files
  bucket       = module.cloudfront.s3_bucket_web_id
  key          = each.key
  source       = each.value.source_path
  content_type = each.value.content_type
  etag         = filemd5(each.value.source_path)
}