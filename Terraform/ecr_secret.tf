
data "aws_ecr_authorization_token" "token" {}

resource "kubernetes_secret" "ecr_secret" {
  metadata {
    name      = "ecr-registry-secret"
    namespace = "default"
  }

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${data.aws_ecr_authorization_token.token.proxy_endpoint}" = {
          "username" = "AWS"
          "password" = data.aws_ecr_authorization_token.token.password
          "email"    = "vaishnv910@gmail.com"
        }
      }
    })
  }

  type = "kubernetes.io/dockerconfigjson"
}


#  Explanation:
# aws_ecr_authorization_token: Fetches the authorization token for ECR.
# kubernetes_secret: Creates a Kubernetes secret with Docker registry credentials.
# .dockerconfigjson: Encodes the credentials in Docker format.
# namespace: Ensure the namespace matches where your pods will run.
