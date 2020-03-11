#!/bin/bash

set -eux

dir=$(dirname "$0")
if [ ! -d "laravel-base" ]; then
  echo "no laravel-base dir found!"
  exit 1
fi

if [ -d "laravel-base-backup" ]; then
  echo "please remove backup dir first"
  exit 1
fi

mv laravel-base laravel-base-backup
mkdir laravel-base
cd laravel-base

composer create-project laravel/laravel .
composer require oomphinc/composer-installers-extender
composer require --dev thisisdevelopment/laravel-base-dev:^0.1.3 roave/security-advisories:dev-master

mkdir -p app/App
shopt -s extglob
mv app/!(App) app/App
mkdir -p app/Domain/vendor
mkdir -p app/Module
mkdir -p app/Support

jq --slurp '.[0] * .[1]' composer.json "../${dir}/composer-base.json" > composer.json.new
mv composer.json.new composer.json

cp -a ../${dir}/files/. ./
cat "../${dir}/gitignore" >> .gitignore

rm .env
rm -rf vendor/*
rm composer.lock

mv ../laravel-base-backup/.git ./
git status
