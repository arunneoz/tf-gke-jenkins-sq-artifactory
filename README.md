## Step 1  Create the GCS Service Account for Spinnaker Config
```
gcloud config set project <your project id>

GCS_SA=gcs-service-account

gcloud iam service-accounts create $GCS_SA \
    --project=$GCP_PROJECT \
    --display-name $GCS_SA

GCS_SA_EMAIL=$(gcloud iam service-accounts list \
    --project=$GCP_PROJECT \
    --filter="displayName:$GCS_SA" \
    --format='value(email)')

gcloud projects add-iam-policy-binding $GCP_PROJECT \
    --role roles/storage.admin \
    --member serviceAccount:$GCS_SA_EMAIL

gcloud projects add-iam-policy-binding $GCP_PROJECT \
    --member serviceAccount:$GCS_SA_EMAIL \
    --role roles/browser
    
GCS_SA_DEST=gcp.json

mkdir -p $(dirname $GCS_SA_DEST)

GCS_SA_EMAIL=$(gcloud iam service-accounts list \
    --filter="displayName:$GCS_SA" \
    --format='value(email)')

gcloud iam service-accounts keys create $GCS_SA_DEST \
    --iam-account $GCS_SA_EMAIL
```

## Step 2 Clone the Repo and download the istio version

```
 git clone https://github.com/arunneoz/terraform-gke-istio

 cd terraform-gke-istio
 
 replace the jsonKey and password with downloaded gcp.json contents in the Step 1 in spinnaker_values.yaml
    
 export ISTIO_VERSION=1.0.0
    
 curl -L https://git.io/getLatestIstio | ISTIO_VERSION=${ISTIO_VERSION} sh
    
 ```

## Step 3 Setting up Terraform

```

mkdir gkeistiospininstall

cd gkeistiospininstall

vi main.tf and paste the following contents

module "k8s_cluster" {
  source = "github.com/arunneoz/terraform-gke-istio"

  gcp_project = "google-project-id"
  gcp_region  = "us-east4"
  
  cluster_name    = "test-cluster"
  cluster_region  = "us-east4"
  node_count      = 1
  master_username = "admin"
  master_password = "this_is_a_pretty_long_password_we_will_should_change!"

  helm_repository = "https://<gcs_bucket>.storage.googleapis.com"
}

terraform init
terraform plan -out gke_istio_spin.plan
terraform apply "gke_istio_spin.plan"


```
