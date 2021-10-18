# README

Simples solução em Rails + VueJS para atender [desafio](https://github.com/Artia/desafios-desevolvimento/blob/master/desafio-fullstack.md) do [Grupo EUAX](https://grupoeuax.com.br/carreira/).


API em JSON escrita em Rails 5.2.6, Ruby 2.7.4 "dockerizada"


* Ruby version

* System dependencies

* Configuração

```sh
$ docker-compose build
$ docker-compose run web bundle install
```

* Criação do banco de dados
```sh
$ docker-compose run web rails db:create
```

* Criação das tabelas

```sh
$ docker-compose run web rails db:migrate
```

* Para executar os testes
```sh
$ docker-compose run web rspec
```

* Para rodar em ambiente de desenvolvimento

```sh
$ docker-compose run -d
```

Então acesso pelo seu browser predileto [desafio](http://127.0.0.1:3791)

* Para colocar em produção

Essa fiquei devendo :D
