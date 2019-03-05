docker build -t xciber/multi-client:latest -t xciber/multi-client:$SHA ./client/Dockerfile ./client
docker build -t xciber/multi-server:latest -t xciber/multi-server:$SHA ./server/Dockerfile ./server
docker build -t xciber/multi-worker:latest -t xciber/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push xciber/multi-client:latest
docker push xciber/multi-server:latest
docker push xciber/multi-worker:latest

docker push xciber/multi-client:$SHA
docker push xciber/multi-server:$SHA
docker push xciber/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=xciber/multi-server:$SHA
kubectl set image deployments/client-deployment client=xciber/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xciber/multi-worker:$SHA