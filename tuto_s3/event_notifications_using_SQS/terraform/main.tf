resource "aws_sqs_queue" "queue" {
  name = "s3-event-notification-queue"



  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Test22bf6867",
      "Effect": "Allow",
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:us-east-1:000000000000:s3-event-notification-queue",
      "Principal": {
        "Service": [
          "s3.amazonaws.com"
        ]
      },
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "arn:aws:s3:::s3-event-notification-bucket"
        }
      }
    }
  ]
}
POLICY
}



resource "aws_s3_bucket" "bucket" {
  bucket = "s3-event-notification-bucket"
}
/*link bucket with SQS*/
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  queue {
    queue_arn = aws_sqs_queue.queue.arn
    events    = ["s3:ObjectCreated:*"]
  }
}



