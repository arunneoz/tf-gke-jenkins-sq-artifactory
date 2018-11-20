module "k8s_cluster" {
  source = "github.com/arunneoz/tf-gke-jenkins-sq-artifactory"

  gcp_project = "inbound-rune-cicdtaw"
  gcp_region  = "us-east4"
  master_version  = "1.10.9-gke.5"
  cluster_name    = "gke-cluster"
  cluster_region  = "us-east4"
  min_node_count  = 2
  max_node_count  = 3
  master_username = "admin"
  master_password = "this_is_a_pretty_long_password_we_will_should_change!"

  helm_repository = "https://storage.googleapis.com/istio-prerelease/daily-build/master-latest-daily/charts"
}
