#!/bin/bash
echo "setting up tables..."
cat db/00_create_tables.sql | sqlite3 stay_or_go.db

echo "performing initial fill.."
cat db/01_initial_fill.sql | sqlite3 stay_or_go.db

echo "done :-)"
