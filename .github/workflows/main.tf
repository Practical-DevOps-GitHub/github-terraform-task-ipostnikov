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
  owner = var.org_name
  repository = var.repo_name
}


resource "github_repository_collaborator" "softservedata" {
  repository = var.repo_name
  username   = "softservedata"
}


resource "github_branch_default" "default_branch" {
  repository = var.repo_name
  branch = "develop"
}