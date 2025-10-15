resource "aws_ecr_repository" "ecr-repository" {
  name                 = "meu-website"
  image_tag_mutability = "MUTABLE"

}