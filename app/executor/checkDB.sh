#!/usr/bin/env bash
psql --pset pager=off -h db -U postgres -A -c "SELECT id, code FROM submissions WHERE pending;"
