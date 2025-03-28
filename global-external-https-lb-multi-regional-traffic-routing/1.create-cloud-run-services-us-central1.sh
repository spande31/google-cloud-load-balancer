# Create cloud run api services 
gcloud run deploy cart-api-cr --image=us-docker.pkg.dev/cloudrun/container/hello --allow-unauthenticated --region=us-central1
gcloud run deploy profile-api-cr --image=us-docker.pkg.dev/cloudrun/container/hello --allow-unauthenticated --region=us-central1
gcloud run deploy placeorder-api-cr --image=us-docker.pkg.dev/cloudrun/container/hello --allow-unauthenticated --region=us-central1

# Create neg for each services
gcloud compute network-endpoint-groups create cart-api-neg \
    --region=us-central1 \
    --network-endpoint-type=serverless  \
    --cloud-run-service=cart-api-cr
      
gcloud compute network-endpoint-groups create profile-api-neg \
    --region=us-central1 \
    --network-endpoint-type=serverless  \
    --cloud-run-service=profile-api-cr

gcloud compute network-endpoint-groups create placeorder-api-neg \
    --region=us-central1 \
    --network-endpoint-type=serverless  \
    --cloud-run-service=placeorder-api-cr

# Create backend services for each negs
gcloud compute backend-services create cart-api-bs \
    --load-balancing-scheme=EXTERNAL_MANAGED \
    --global

gcloud compute backend-services create profile-api-bs \
    --load-balancing-scheme=EXTERNAL_MANAGED \
    --global

gcloud compute backend-services create placeorder-api-bs \
    --load-balancing-scheme=EXTERNAL_MANAGED \
    --global

# Attach negs to corresponding backend services
gcloud compute backend-services add-backend cart-api-bs \
    --global \
    --network-endpoint-group=cart-api-neg \
    --network-endpoint-group-region=us-central1

gcloud compute backend-services add-backend profile-api-bs \
    --global \
    --network-endpoint-group=profile-api-neg \
    --network-endpoint-group-region=us-central1

gcloud compute backend-services add-backend placeorder-api-bs \
    --global \
    --network-endpoint-group=placeorder-api-neg \
    --network-endpoint-group-region=us-central1
