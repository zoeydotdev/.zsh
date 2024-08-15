#!/usr/bin/env bash

function recap()           { recap_by_range             "$@"; }
function recap_day()       { recap_by_dates  --days=1   "$@"; }
function recap_day_all()   { recap_all       --days=1   "$@"; }
function recap_week()      { recap_by_dates  --days=7   "$@"; }
function recap_week_all()  { recap_all       --days=7   "$@"; }
function recap_month()     { recap_by_dates  --days=31  "$@"; }
function recap_month_all() { recap_all       --days=31  "$@"; }
