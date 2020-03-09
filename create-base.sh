#!/bin/bash

dir=$(dirname "$0")

composer create-project laravel/laravel .

composer require oomphinc/composer-installers-extender
composer require --dev thisisdevelopment/laravel-base-dev
composer require --dev roave/security-advisories:dev-master

mkdir -p app/App
mv app/* app/App
mkdir -p app/Domain/vendor
mkdir -p app/Module
mkdir -p app/Support

jq --slurp '.[0] * .[1]' composer.json "${dir}/composer-base.json" > composer.json.new
mv composer.json.new composer.json

cp -a ${dir}/files/. ./
cat "${dir}/gitignore" >> .gitignore

composer update

rm .env
rm -rf vendor/*
