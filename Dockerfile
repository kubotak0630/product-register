FROM ruby:2.5
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    yarn

WORKDIR /product-register
COPY Gemfile Gemfile.lock /product-register/
RUN bundle install

# docker build build-arg=$(id -u) で上書きする
ARG UID=unknow
# --build-arg=$(id -g) で上書きする
ARG GID=unknow
# コンテナ内に名称dockerでグループを作成
# コンテナ内に名称dockerでdockerグループに所属するユーザーを作成
RUN groupadd -g ${GID} docker && \
    useradd -u ${UID} -g ${GID} -s /bin/bash -M docker

# コンテナを実行するユーザーを指定
USER ${UID}



