# build images
docker build -t tpreston96/multi-client:latest -t tpreston96/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tpreston96/multi-server:latest -t tpreston96/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tpreston96/multi-worker:latest -t tpreston96/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tpreston96/multi-client:latest
docker push tpreston96/multi-server:latest
docker push tpreston96/multi-worker:latest

docker push tpreston96/multi-client:$SHA
docker push tpreston96/multi-server:$SHA
docker push tpreston96/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=tpreston96/multi-server:$SHA
kubectl set image deployments/client-deployment client=tpreston96/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tpreston96/multi-worker:$SHA