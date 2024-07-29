#!/usr/bin/env bash

################################################
##  Script Information
################################################

DEFAULT_D="300s"
DEFAULT_V="v0"

read -r -d '' HELP << EOF
Description:
    Script that provides conveniences for performance/load testing deployed
    API services in higher and lower environments.

Usage: wrk.sh --service=<SERVICE> --siteId=<SITE_ID> --env=<ENV> [<options>]
   or: wrk.sh -s<SERVICE> -i<SITE_ID> -e<ENV> [<options>]

    [-h|--help]                     Print this help message and exit.
    [-s|--service=]<SERVICE>        REQUIRED. Service being tested.
    [-i|--siteId=]<SERVICE>         REQUIRED. Site ID being tested.
    [-e|--env=]<ENV>                REQUIRED. Test environment of the service.
    [-d|--duration=]<DURATION>      Defaults to ${DEFAULT_D}. Duration of the test, e.g: 2s, 2m, 2h.
    [-v|--version=]<VERSION>        Defaults to ${DEFAULT_V}. API version identifier, e.g.: v0, v1, v2.
    [-l|--logfile=]<LOGFILE>        Pipes a timestamp and test results to file if provided.
    [-t|--threads=]<N_THREADS>      Defaults to T = 2 * (total CPU core count) threads.
                                    Total number of CPU threads used to connect with
                                    each thread handling N = connections/threads.
    [-c|--conns=]<N_CONNS>          Defaults to C = 1 + (2 * T) connections.
                                    Total number of HTTP connections to keep open with
                                    each thread handling N = connections/threads.
EOF

function get_help() { echo "$HELP"; exit $1; }
function get_unsup_help() { echo "Illegal argument: wrk.sh $@"; echo; get_help 1; }

################################################
##  Parse arguments
################################################

for ARGUMENT in "$@"; do
    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)

    case "$KEY" in
        -s*)        SERVICE=${KEY/-s/}         ;;
        --service)  SERVICE=${VALUE}           ;;

        -i*)        SITE_ID=${KEY/-i/}         ;;
        --siteId)   SITE_ID=${VALUE}           ;;

        -e*)        ENV=${KEY/-e/}             ;;
        --env)      ENV=${VALUE}               ;;

        -d*)        DURATION=${KEY/-d/}        ;;
        --duration) DURATION=${VALUE}          ;;

        -v)         VERSION=${KEY/-v/}         ;;
        --version)  VERSION=${VERSION}         ;;

        -l*)        LOGFILE=${KEY/-l/}         ;;
        --logfile)  LOGFILE=${VALUE}           ;;

        -t*)        NUM_THREADS=${KEY/-t/}     ;;
        --threads)  NUM_THREADS=${VALUE}       ;;

        -c*)        NUM_CONNECTIONS=${KEY/-c/} ;;
        --conns)    NUM_CONNECTIONS=${VALUE}   ;;

        -h)         get_help 0                 ;;
        --help)     get_help 0                 ;;
        *)          get_unsup_help $@          ;;
    esac
done

[[ -z $SERVICE || -z $SITE_ID || -z $ENV ]] && get_help 2;

[[ -z "$NUM_THREADS" ]]      && NUM_THREADS=$((($(sysctl -n hw.ncpu) * 2)))
[[ -z "$NUM_CONNECTIONS" ]]  && NUM_CONNECTIONS=$(((${NUM_THREADS} * 2) + 1))
[[ -z "$DURATION" ]]         && DURATION=$DEFAULT_D
[[ -z "$VERSION" ]]          && VERSION=$DEFAULT_V

################################################
##  Obtain auth token
################################################

function get_auth_token () {
    curl -s -L -X POST "${1}/api/token/v0/${2}/auth" \
        -H 'Content-Type: application/json' -d '' | jq -r '.authToken'
}

ENDPOINT=$( get_site_by_env --siteId=$SITE_ID --env=$ENV )
AUTH_TOKEN=$( get_auth_token $ENDPOINT $SITE_ID )

################################################
##  Test performance
################################################

wrk_script=$(ls *wrk.lua | head -n 1)

if [[ -z "$LOGFILE" ]]; then
    read -r -d '' CMD << EOF
    wrk -s ${wrk_script} -t${NUM_THREADS} -c${NUM_CONNECTIONS} --latency -d${DURATION} \
        -H 'Authorization: Bearer ${AUTH_TOKEN}' \
        ${ENDPOINT}/api/${SERVICE}/${VERSION}/${SITE_ID}
EOF
else
    TODAY=$( date -u "+%Y-%m-%d %T %Z" )
    read -r -d '' CMD << EOF
    echo "## Test ran on ${TODAY}" >> ${LOGFILE} && echo >> ${LOGFILE} \
    && echo '\`\`\`' >> ${LOGFILE} \
    && wrk -s ${wrk_script} -t${NUM_THREADS} -c${NUM_CONNECTIONS} --latency -d${DURATION} \
        -H 'Authorization: Bearer ${AUTH_TOKEN}' \
        ${ENDPOINT}/api/${SERVICE}/${VERSION}/${SITE_ID} >> ${LOGFILE} \
    && echo '\`\`\`' >> ${LOGFILE};
EOF
fi

eval $CMD
