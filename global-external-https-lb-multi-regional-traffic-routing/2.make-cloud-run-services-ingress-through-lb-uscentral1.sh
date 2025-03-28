# Create cloud run api services 
gcloud run services update cart-api-cr --ingress=internal-and-cloud-load-balancing --region=us-central1
gcloud run services update profile-api-cr --ingress=internal-and-cloud-load-balancing --region=us-central1
gcloud run services update placeorder-api-cr --ingress=internal-and-cloud-load-balancing --region=us-central1