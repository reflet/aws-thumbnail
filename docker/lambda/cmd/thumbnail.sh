#!/bin/bash

source /root/.bashrc

if [ -z "$CODE_VERSION" ]; then
    echo -e "環境変数「CODE_VERSION」が定義されていません\n"
    exit 1
fi

compile() {
    mkdir -p /tmp/thumbnail-function/
    cd /tmp/thumbnail-function/
    cp /src/thumbnail-function/index.js .
    npm init -f -y;
    npm install async gm --save;
    npm install --only=prod
}
package() {
    mkdir -p /dist
    cd /tmp/thumbnail-function/
    file="/dist/thumbnail-function.${CODE_VERSION}.zip"
    zip -FS -q -r "${file}" *
    echo "export: ${file}"
}

while getopts ":-:" opt; do
    case "$opt" in
        -)
            case "${OPTARG}" in
                package)
                    compile
                    package
                    exit 0 ;;
                *) ;;
            esac ;;
    esac
done

echo -e "Usage: thumbnail.sh --package\n"
exit 1
