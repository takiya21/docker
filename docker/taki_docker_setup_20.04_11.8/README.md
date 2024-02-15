# Memo for creating docker container on 2023/06/20

## 必要なもの

* cuda : 自分の使用したいバージョンに合わせて、適宜dockerfileを更新 + gpuのnvidia-driverを更新すること
* nvidia-docker2 : たまにインストールし忘れているgpuがあるので注意

## 編集が必要なファイル

* docker-compose.yml：hostname, container_name, image, portsを適宜変更する
* build/Dockerfile：1行目を使用したいcudaバージョンに合わせて変更（参考：https://hub.docker.com/r/nvidia/cuda/tags?page=1&ordering=last_updated ）
* exec.sh：dockerコンテナのrootユーザにログインするshell script。<your container name>にコンテナ名を入力する。

## Portfowarding example

必要に応じて自分に割り当てられたポート番号を使用する。
ポート番号の割り当ては以下を参照：
https://docs.google.com/spreadsheets/d/1lTFTDwoAf_W3r1QtNZFpbSBec4tG5pjG_IoWEcKD4mY/edit?usp=sharing

例：54000-54999が割り当てられている場合のポートフォワーディング

* [ssh] 54022:22
* [jupyter] 54888:8888
* [tensorboard] 54006:6006

## Process example

※自分のGitLabにdocker用のリポジトリを作成することを推奨。本リポジトリはそのベース用に作成した。

```bash
:~/$ git clone http://10.226.47.83:8080/taki/taki_docker_setup_20.04_11.8.git
:~/$ cd taki_docker_setup_20.04_11.8
:~/taki_docker_setup_20.04_11.8/$ sudo docker compose up -d
:~/taki_docker_setup_20.04_11.8/$ bash exec.sh #rootユーザにログインする場合
:~/taki_docker_setup_20.04_11.8/$ ssh <username>@10.226.47.** -p <your docker container port for ssh> #LDAPユーザにログインする場合
```

## 失敗した場合のDocker消し方
```bash
:~/$ sudo docker ps -a # CONTAINER IDを控える
:~/$ sudo docker rm [CONTAINER ID]
:~/$ sudo docker images # IMAGE IDを控える
:~/$ sudo docker rmi [IMAGE ID]
:~/$ cd
:~/$ sudo rm -rf taki_docker_setup_20.04_11.8
```

