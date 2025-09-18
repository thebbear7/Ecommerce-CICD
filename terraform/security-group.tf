resource "aws_security_group" "eks_sg" {
  name        = "ecomm-sg"
  description = "Security group for EKS cluster and nodes"
  vpc_id      = module.vpc.vpc_id   # attach to the VPC you created

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]     # open to internet (can be restricted later)
  }


  ingress {
    description = "Allow internal communication between nodes"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true              # allow within this SG
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ecomm-eks-sg"
    Environment = "dev"
  }
}
