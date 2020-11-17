docker build -t idalavye/multi-client:latest -t idalavye/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t idalavye/multi-server:latest -t idalavye/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t idalavye/multi-worker:latest -t idalavye/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push idalavye/multi-client:latest
docker push idalavye/multi-server:latest
docker push idalavye/multi-worker:latest

docker push idalavye/multi-client:$SHA
docker push idalavye/multi-server:$SHA
docker push idalavye/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=idalavye/multi-server:$SHA
kubectl set image deployments/client-deployment server=idalavye/client-server:$SHA
kubectl set image deployments/worker-deployment server=idalavye/worker-server:$SHA
