resource "aws_iam_instance_profile" "testprofile" {
  name = "${var.environment}-webapp-profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "${var.environment}-webapp-role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
data "aws_iam_policy" "policy" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = data.aws_iam_policy.policy.arn
}