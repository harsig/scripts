#!/usr/bin/env bash
# ---
# name: date
# description: Show the current date and time, optionally in another time zone or format.
# parameters:
#   timezone:
#     type: string
#     description: IANA time zone, e.g. Europe/Berlin or UTC (default is the local time zone)
#   format:
#     type: string
#     description: Output format
#     enum: [iso, rfc, date, time, unix]
#     default: iso
# ---
set -euo pipefail

if [[ -n "${PARAM_TIMEZONE:-}" ]]; then
  if [[ ! -e "/usr/share/zoneinfo/$PARAM_TIMEZONE" ]]; then
    echo "unknown time zone: $PARAM_TIMEZONE" >&2
    exit 2
  fi
  export TZ="$PARAM_TIMEZONE"
fi

case "${PARAM_FORMAT:-iso}" in
  iso)  date --iso-8601=seconds ;;
  rfc)  date --rfc-email ;;
  date) date +%F ;;
  time) date +%T ;;
  unix) date +%s ;;
esac
