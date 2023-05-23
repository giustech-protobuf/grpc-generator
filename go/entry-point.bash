#!/bin/bash

mkdir -p /generated
rm -rf /copied-files
mkdir -p /copied-files
cp -rp /files/proto/* /copied-files

echo "****************** Start Compiler *********************"


protoc_files () {
    shopt -s nullglob dotglob
    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            protoc_files "$pathname"
        else
            case "$pathname" in *.proto)
                fname=`basename $pathname`
                dirName=`dirname $pathname`
                protoc $fname --proto_path=$dirName --go_out=/generated --go-grpc_out=/generated
            esac
        fi
    done
}

move_go_files () {
    shopt -s nullglob dotglob
    for pathname in "$1"/*; do
        if [ -d "$pathname" ]; then
            move_go_files "$pathname"
        else
            case "$pathname" in *.go)
                fname=`basename $pathname`
                dirName=`dirname $pathname`
                correct_dir=${dirName//.\//}
                path_final=${correct_dir/$preffix_pkg_application/}
                rm -rf /protobuf/$path_final/$fname
                mkdir -p /protobuf/$path_final
                mv $correct_dir/$fname /protobuf/$path_final/$fname
            esac
        fi
    done
}

cd /copied-files
protoc_files "."

cd /generated/
move_go_files "."

