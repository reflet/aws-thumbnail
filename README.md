# サムネイル画像 (Lambda)

## 環境変数の定義
dockerコンテナが使用する定数を設定する。

```
$ export AWS_ACCESS_KEY_ID='xxxxxxxxxxxxx'
$ export AWS_SECRET_ACCESS_KEY='xxxxxxxxxxxxxxxxxx'
$ export STACK_NAME='sample-ms-thumb'
$ export CODE_BUCKET='sample-ms-thumb-func'
$ export IMAGE_BUCKET='sample-ms-thumb'
$ export CODE_VERSION='v1'
```

## デプロイ
CloudFormationでStackを登録してAWSの各リソースを自動生成する。

```
$ export CODE_VERSION='v1'
  docker-compose build && \
  docker-compose run --rm lambda /root/thumbnail.sh --package && \
  docker-compose run --rm aws-cli /root/code.sh --create && \
  docker-compose run --rm aws-cli /root/lambda.sh --deploy
```

## lamda関数の更新

JavaScriptを変更して、CloudFormationでStackを更新し、lambdaのリソースを再構築する。

```
# ↓ 最新バージョン＋１を指定する
$ export CODE_VERSION='v3' && \
  docker-compose build && \
  docker-compose run --rm lambda /root/thumbnail.sh --package && \
  docker-compose run --rm aws-cli /root/code.sh --upload && \
  docker-compose run --rm aws-cli /root/lambda.sh --deploy
```

以上

## 参考サイト

* [AWSドキュメント - Amazon S3 で AWS Lambda を使用する](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/with-s3-example.html)
* [S3の画像アップロードをトリガーにサムネイル画像を自動生成する](https://beyondjapan.com/blog/2017/04/lambda-image-auto-resize)
* [S3にcreateObjectをトリガーにLambdaを起動するCloudformationテンプレート](https://dev.classmethod.jp/cloud/cloudformation-s3-put-event/)
* [LambdaでS3にアップロードされが画像をサムネイルにしてみた](https://mediaash.com/2015/11/12/lambda-s3thumbnail/)
* [CloudFrontでマルチオリジンとCache Behavior設定してみた](https://dev.classmethod.jp/cloud/aws/cloudfront-multioriginbehavior/)
