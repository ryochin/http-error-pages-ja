HTTP サーバ用 汎用日本語 HTML エラーページ集
===================

[![CC0](http://img.shields.io/badge/license-CC0-blue.svg?style=flat)](LICENSE)

> ウェブサーバのデフォルトページよりはマシな、**使いものになる**エラーページたち。

![screenshot](screenshot@2x.png)

* どんなサービスにもマッチする、ミニマルなデザイン。
* 過不足なく、わかりやすいメッセージ。
* カスタマイザブル。

設定 on nginx
-------------

ファイル一式をクローンし、`errors.conf` を作成する。

```sh
git clone --depth=1 https://github.com/ryochin/http-error-pages-ja.git /var/nginx/errors
vi /var/nginx/conf/errors.conf
```

```nginx
error_page 400 /400.html;
error_page 401 /401.html;
error_page 402 /402.html;
error_page 403 /403.html;
error_page 404 /404.html;
error_page 405 /405.html;
error_page 406 /406.html;
error_page 407 /407.html;
error_page 408 /408.html;
error_page 409 /409.html;
error_page 410 /410.html;
error_page 411 /411.html;
error_page 412 /412.html;
error_page 413 /413.html;
error_page 414 /414.html;
error_page 415 /415.html;
error_page 416 /416.html;
error_page 417 /417.html;
error_page 421 /421.html;
error_page 422 /422.html;
error_page 423 /423.html;
error_page 424 /424.html;
error_page 425 /425.html;
error_page 426 /426.html;
error_page 428 /428.html;
error_page 429 /429.html;
error_page 431 /431.html;
error_page 451 /451.html;
error_page 500 /500.html;
error_page 501 /501.html;
error_page 502 /502.html;
error_page 503 /503.html;
error_page 504 /504.html;
error_page 505 /505.html;
error_page 506 /506.html;
error_page 507 /507.html;
error_page 508 /508.html;
error_page 509 /509.html;
error_page 510 /510.html;
error_page 511 /511.html;

location ^~ /_errors/ {
    root /var/nginx/errors;
    allow all;
}

location ~ ^/(4[01235][0-9]|5[01][0-9])\.html$ {
    root /var/nginx/errors;
    allow all;
    internal;
}
```

`nginx.conf` に追記する。

```nginx
server {
    ...
    include               /var/nginx/conf/errors.conf;
}
```

`root` パスは適宜変更する。

カスタマイズ
----

### ビルドする

文言やレイアウトを編集し、HTML ファイル群を生成する。

```sh
vi http_status_code.yml
vi template.html

./build.rb
```

デザインを編集する。

```sh
vi _errors/style.css
```

### 確認する

表示用にローカルのウェブサーバを起動する。

```sh
docker compose up

open http://localhost:20080/
```

リソース
--------

* [HTTP レスポンスステータスコード (MDN web docs)](https://developer.mozilla.org/ja/docs/Web/HTTP/Status)
* [HTTPステータスコード (wikipedia)](https://ja.wikipedia.org/wiki/HTTP%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9%E3%82%B3%E3%83%BC%E3%83%89)
* [denysvitali/nginx-error-pages](https://github.com/denysvitali/nginx-error-pages)

License
-------

CC0 1.0 Universal, Public Domain
