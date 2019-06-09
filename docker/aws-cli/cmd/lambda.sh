#!/bin/bash

source /root/.bashrc

if [ -z "${STACK_NAME}" ]; then
    echo "環境変数「STACK_NAME」が定義されていません\n"
    exit 1
fi
if [ -z "${IMAGE_BUCKET}" ]; then
    echo "環境変数「IMAGE_BUCKET」が定義されていません\n"
    exit 1
fi
if [ -z "${CODE_BUCKET}" ]; then
    echo -e "環境変数「CODE_BUCKET」が定義されていません\n"
    exit 1
fi
if [ -z "$CODE_VERSION" ]; then
    echo -e "環境変数「CODE_VERSION」が定義されていません\n"
    exit 1
fi

init() {
    YAML="template.yml"
    SRC="/src/${YAML}"
    FILE="/root/${YAML}"

    if [ -e "${FILE}" ]; then
      rm -f ${FILE}
    fi

    cp ${SRC} ${FILE}
    sed -i "s/<image-bucket>/${IMAGE_BUCKET}/g" ${FILE}
    sed -i "s/<code-bucket>/${CODE_BUCKET}/g" ${FILE}
    sed -i "s/<code-version>/${CODE_VERSION}/g" ${FILE}
}
deploy() {
    aws cloudformation deploy \
        --template-file ${FILE} \
        --stack-name "${STACK_NAME}" \
        --capabilities CAPABILITY_NAMED_IAM CAPABILITY_IAM
}

# 引数(オプション)
while getopts ":-:" opt; do
    case "$opt" in
        -)
            case "${OPTARG}" in
                deploy)
                    init
                    deploy
                    exit 0 ;;
                *) ;;
            esac ;;
    esac
done

echo -e "Usage: lambda.sh --deploy\n"
exit 1
