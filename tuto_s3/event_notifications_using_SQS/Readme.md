Create a new file named some-log-file.log and upload it to the S3 bucket using the AWS CLI:

echo "Hello, LocalStack" > some-log-file.log
awslocal s3 cp some-log-file.log s3://s3-event-notification-bucket/

You can confirm that the S3 bucket is correctly set up for event notifications through the SQS queue by checking if the message is received in the SQS queue:

awslocal sqs receive-message \
    --queue-url http://sqs.us-east-1.localhost.localstack.cloud:4566/000000000000/s3-event-notification-queue


