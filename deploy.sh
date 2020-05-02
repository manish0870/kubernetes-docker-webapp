docker build -t redhook/multi-client:latest -t redhook/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t redhook/multi-server:latest -t redhook/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t redhook/multi-worker:latest -t redhook/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push redhook/multi-client:latest
docker push redhook/multi-server:latest
docker push redhook/multi-worker:latest

docker push redhook/multi-client:$SHA
docker push redhook/multi-server:$SHA
docker push redhook/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=redhook/multi-client:$SHA
kubectl set image deployments/server-deployment server=redhook/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=redhook/multi-worker:$SHA
