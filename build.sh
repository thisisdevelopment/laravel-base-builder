docker build -t base-builder .
cd ../
docker run -u $(id -u):$(id -g) -v $(pwd):/var/www -it base-builder ./laravel-base-builder/create-base.sh
cd laravel-base
git status
