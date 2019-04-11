#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
	realpath() { [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"; }
	ROOT=$(dirname $(dirname $(realpath "$0")))
else
	ROOT=$(dirname $(dirname $(readlink -f $0)))
fi

function code() {
	cd $ROOT

	# Sync built-in extensions
	node build/lib/builtInExtensions.js

	NODE_ENV=development \
	VSCODE_DEV=1 \
	node "$ROOT/out/remoteExtensionHostAgent.js" "$@"
}

code "$@"
