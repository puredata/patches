#!/bin/sh
pd-extended vatAudio.pd &
sleep 2
pd-extended -nrt -noaudio vatVideo.pd &
