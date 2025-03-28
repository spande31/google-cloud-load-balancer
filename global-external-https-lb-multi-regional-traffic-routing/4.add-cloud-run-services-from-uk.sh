# Create cloud run api services in uk (europe-west2) with same service names
gcloud run deploy cart-api-cr --image=us-docker.pkg.dev/cloudrun/container/hello --allow-unauthenticated --region=europe-west2 --ingress=internal-and-cloud-load-balancing
gcloud run deploy profile-api-cr --image=us-docker.pkg.dev/cloudrun/container/hello --allow-unauthenticated --region=europe-west2 --ingress=internal-and-cloud-load-balancing
gcloud run deploy placeorder-api-cr --image=us-docker.pkg.dev/cloudrun/container/hello --allow-unauthenticated --region=europe-west2 --ingress=internal-and-cloud-load-balancing

gcloud run deploy cart-api-cr --image=us-docker.pkg.dev/cloudrun/container/hello --allow-unauthenticated --region=europe-west2
gcloud run deploy profile-api-cr --image=us-docker.pkg.dev/cloudrun/container/hello --allow-unauthenticated --region=europe-west2
gcloud run deploy placeorder-api-cr --image=us-docker.pkg.dev/cloudrun/container/hello --allow-unauthenticated --region=europe-west2

# Create neg for each services
gcloud compute network-endpoint-groups create cart-api-neg --region=europe-west2 --network-endpoint-type=serverless --cloud-run-service=cart-api-cr
gcloud compute network-endpoint-groups create profile-api-neg --region=europe-west2 --network-endpoint-type=serverless --cloud-run-service=profile-api-cr
gcloud compute network-endpoint-groups create placeorder-api-neg --region=europe-west2 --network-endpoint-type=serverless --cloud-run-service=placeorder-api-cr

# Attach negs to corresponding backend services
gcloud compute backend-services add-backend cart-api-bs --global --network-endpoint-group=cart-api-neg --network-endpoint-group-region=europe-west2
gcloud compute backend-services add-backend profile-api-bs --global --network-endpoint-group=profile-api-neg --network-endpoint-group-region=europe-west2
gcloud compute backend-services add-backend placeorder-api-bs --global --network-endpoint-group=placeorder-api-neg --network-endpoint-group-region=europe-west2
