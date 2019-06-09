#!/bin/bash

source /root/.bashrc

if [ -z "${CODE_BUCKET}" ]; then
    echo -e "環境変数「CODE_BUCKET」が定義されていません\n"
    exit 1
fi
if [ -z "$CODE_VERSION" ]; then
    echo -e "環境変数「CODE_VERSION」が定義されていません\n"
    exit 1
fi

create() {
    aws s3 mb s3://${CODE_BUCKET}
}
upload() {
    aws s3 cp /dist/thumbnail-function.${CODE_VERSION}.zip s3://${CODE_BUCKET}/
}
clear() {
    rm -f /dist/thumbnail-function.${CODE_VERSION}.zip
}

# 引数(オプション)
while getopts ":-:" opt; do
    case "$opt" in
        -)
            case "${OPTARG}" in
                create)
                    create
                    upload
                    clear
                    exit 0 ;;
                upload)
                    upload
                    clear
                    exit 0 ;;
                *) ;;
            esac ;;
    esac
done

echo -e "Usage: code.sh [--create] [--upload]\n"
exit 1
