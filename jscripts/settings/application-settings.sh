#!/usr/bin/env bash

[[ -n "${_APPLICATION_SETTINGS_SH:+_}" ]] && return || readonly _APPLICATION_SETTINGS_SH=1

function get_current_application_version {
    cat version.txt
}
