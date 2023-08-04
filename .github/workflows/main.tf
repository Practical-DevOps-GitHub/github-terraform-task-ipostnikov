terraform {
  required_version = ">=0.13"
  required_providers {
    github = {
      source = "hashicorp/github"
      version = "4.3.2"
    }
  }
}


provider "github" {
  token        = "${var.PAT}"
}



# Add a collaborator to a repository
resource "github_repository_collaborator" "a_repo_collaborator" {
  repository = "github-terraform-task-ipostnikov"
  username   = "softservedata"
  permission = "push"
}


