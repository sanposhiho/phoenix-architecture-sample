# Phoenix architecture sample

Phoenixにおいて、RDBの使用を前提としたアーキテクチャのサンプルです。

```
lib
├──tsundoku_buster
    ├── behaviour
         └── repository
    ├── database
    ├── schema
    └── usecase
├── tsundoku_buster_web
    ├── controllers
    ├── views
```

(アーキテクチャに関係する部分のみを抜粋)

### behaviour

副作用のあるモジュール(Databaseの操作を行うモジュールなど)のbehaviourを定義します。

### database

RDBの操作を行うモジュールを定義します

### schema

schemaを定義するモジュールを定義します

### usecase

アプリケーションのロジックを実現します。
