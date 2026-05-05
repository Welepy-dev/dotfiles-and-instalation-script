#!/bin/bash
# Kill any existing instances of this script and inotifywait, sparing ourselves
pkill -f inotifywait
pgrep -f sync_folders.sh | grep -v $$ | xargs kill 2>/dev/null

CONFIG_FILE="$HOME/.sync_folders.conf"

# Function to add a sync pair
add_pair() {
	local src=$(realpath "$1")
	local dest=$(realpath "$2")

	if [ -d "$src" ] && [ -d "$dest" ]; then
		echo "$src|$dest" >> "$CONFIG_FILE"
		echo "Added: $src <-> $dest"
	else
		echo "Error: One or both directories do not exist."
		exit 1
	fi
}

# Check for the --add flag
if [[ "$1" == "--add" ]]; then
	if [ -z "$2" ] || [ -z "$3" ]; then
		echo "Usage: $0 --add <source> <destination>"
		exit 1
	fi
	add_pair "$2" "$3"
	exit 0
fi

# Main Sync Logic (Running the script without arguments)
if [ ! -f "$CONFIG_FILE" ]; then
	echo "No folders configured. Use --add to track directories."
	exit 1
fi

echo "Starting Bidirectional Multi-Folder Sync..."

# Associative array to track directories currently being synced
# (prevents feedback loops: A->B change triggering B->A sync)
declare -A SYNCING

sync_dirs() {
	local from="$1"
	local to="$2"

	# If the destination is already pushing a sync, skip to avoid a loop
	if [[ "${SYNCING[$to]}" == "1" ]]; then
		return
	fi

	SYNCING[$from]="1"
	rsync -av --delete "$from/" "$to/"
	SYNCING[$from]="0"
}

# Read the config and start bidirectional watchers for each pair
while IFS="|" read -r dir_a dir_b; do
	echo "Watching (bidirectional): $dir_a <-> $dir_b"

	# Watch dir_a -> sync to dir_b
	(
		while inotifywait -r -e modify,create,delete,move "$dir_a"; do
			sync_dirs "$dir_a" "$dir_b"
		done
	) &

	# Watch dir_b -> sync to dir_a
	(
		while inotifywait -r -e modify,create,delete,move "$dir_b"; do
			sync_dirs "$dir_b" "$dir_a"
		done
	) &

done < "$CONFIG_FILE"

wait
