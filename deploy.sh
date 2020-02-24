#/build docker images with tags of latest and also the specific sha of the commit
docker build -t barrybt23/multi-client:latest -t barrybt23/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t barrybt23/multi-server:latest -t barrybt23/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t barrybt23/multi-worker:latest -t barrybt23/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#/push docker images with specific tags to docker hub
docker push barrybt23/multi-client:latest
docker push barrybt23/multi-server:latest
docker push barrybt23/multi-worker:latest

docker push barrybt23/multi-client:$SHA
docker push barrybt23/multi-server:$SHA
docker push barrybt23/multi-worker:$SHA
#/apply k8s yaml files
kubectl apply -f k8s
#/prompts k8s to deploy the new images based on the new commit or SHA
kubectl set image deployments/server-deployment server=barrybt23/multi-server:$SHA
kubectl set image deployments/client-deployment client=barrybt23/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=barrybt23/multi-worker:$SHA

