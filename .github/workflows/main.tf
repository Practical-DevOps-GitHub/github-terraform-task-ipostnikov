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
  token = var.PAT
  owner = "Practical-DevOps-GitHub"
  repository = "github-terraform-task-ipostnikov"
}


resource "github_repository_collaborator" "softservedata" {
  repository = "github-terraform-task-ipostnikov"
  username   = "softservedata"
}


resource "github_branch_default" "default_branch" {
  repository = github.repository
  branch = "develop"
}