create a bucket named testwebsite using LocalStack’s S3 API:

awslocal s3api create-bucket --bucket testwebsite

Let’s create a file named bucket_policy.json in the root directory and add the following code:

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::testwebsite/*"
        }
    ]
}

Copy
Let’s now attach the policy to the bucket:

awslocal s3api put-bucket-policy --bucket testwebsite --policy file://bucket_policy.json

Copy
With the policy attached, we can now sync the contents of our root directory to the bucket:

awslocal s3 sync ./ s3://testwebsite


We’ll now enable static website hosting on the bucket and configure the index and error documents:

awslocal s3 website s3://testwebsite/ --index-document index.html --error-document error.html


If you are deploying a static website using S3 on real AWS cloud, your S3 website endpoint will follow one of these two formats:

http://<BUCKET_NAME>.s3-website-<REGION>.amazonaws.com
http://<BUCKET_NAME>.s3-website.<REGION>.amazonaws.com
In LocalStack, the S3 website endpoint follows the following format: http://<BUCKET_NAME>.s3-website.localhost.localstack.cloud:4566. You can navigate to http://testwebsite.s3-website.localhost.localstack.cloud:4566/ to view your static website.


