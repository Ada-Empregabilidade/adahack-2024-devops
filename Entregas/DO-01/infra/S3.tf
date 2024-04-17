/**
* Esse arquivo cria um S3 bucket e armazena o arquivo de dockerrun
*/

resource "aws_s3_bucket" "beanstalk_bucket" {
  bucket = "beanstalk-bucket-${var.name}"
}

resource "aws_s3_object" "docker" {
  depends_on = [ aws_s3_bucket.beanstalk_bucket ]
  bucket = "beanstalk-bucket-${var.name}"
  key    = "${var.name}.zip"
  source = "${var.name}.zip"
  etag   = filemd5("${var.name}.zip")
}