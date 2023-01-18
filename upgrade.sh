#!/bin/sh
SOURCE="$TERMINUSDB_QUICKSTART_STORAGE/db"
SOURCE_BACKUP="$SOURCE.10.bkp"
TARGET="$TERMINUSDB_QUICKSTART_STORAGE/db-11"
WORK="$TERMINUSDB_QUICKSTART_STORAGE/work-10-to-11"

if [ ! -e "$SOURCE/STORAGE_VERSION" ]
then
    echo "There is no store discovered at $SOURCE"
    exit 1
fi

VERSION=`cat "$SOURCE/STORAGE_VERSION"`
if [ $VERSION -eq "2" ]
then
    echo "Store is already converted!"
    exit 1
elif [ $VERSION -eq "1" ]
then
    echo "Beginning conversion of TerminusDB 10 store"
else
    echo "Store provided is an unrecognized version: $VERSION"
    exit 1
fi

if [ -e "$SOURCE_BACKUP" ]
then
    echo "There is a source backup already `$SOURCE_BACKUP`, please remove it!"
    exit 1
fi

/app/terminusdb-upgrade/bin/terminusdb-10-to-11 convert-store "$SOURCE" "$TARGET" -w "$WORK"
# Test something
if [ $? -eq 0 ]
then
    mv "$SOURCE" "$SOURCE_BACKUP"
    mv "$TARGET" "$SOURCE"
    rm -rf "$WORK"
    echo "Successful conversion of store"
else
    echo "Failed to convert store!";
fi
