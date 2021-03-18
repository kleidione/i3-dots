#!/usr/bin/env bash

function translate() {
  typing=$(mktemp)
  rm -rf $typing && nano $typing
  msg=$(trans -b :en -no-auto -i $typing)
  typing=$(cat $typing)
  echo "${BOL_RED}Message:${BOL_YEL}${msg}${END}"
}

function gitpush() {
  pwd=$(pwd | cut -c-27)
  if [[ $pwd = "/home/kleidione/Source" ]]; then
    echo "${BOL_RED}No push!${END}"
  else
    if [[ ${1} = amend ]]; then
      echo "${BOL_YEL}Pushing with --force!${END}"
      git push -f
    else
      echo "${BOL_YEL}Pushing!${END}"
      git push
    fi
  fi
}

function cm() {
  translate
  if [[ ${1} ]]; then
    git commit --author "${1}" --date "$(date)" && gitpush
  else
    git commit --message $msg --signoff --author "kleidione Freitas <kleidione@gmail.com>" --date "$(date)" && gitpush
  fi
}

function amend() {
  if [[ ${1} ]]; then
    git commit --author "${1}" --signoff --amend --date "$(date)" && gitpush amend
  else
    git commit --signoff --amend --date "$(date)" && gitpush amend
  fi
}

function push() {
  REPO_CHECK=$(pwd | cut -c1-38)
  if [[ $REPO_CHECK == "/home/kleidione/Source/kraken" ]]; then
    REPO=$(pwd | sed "s/\/home\/kleidione\/Source\/kraken\///; s/\//_/g")
  else
    REPO=$(pwd | sed "s/\/home\/kleidione\/Source\/kraken\///; s/\//_/g")
  fi
  echo $REPO
  GITHOST=github
  ORG=AOSPK
  BRANCH=twelve
  FORCE=${1}
  TOPIC=${2}

  if [[ $REPO = "vendor_gapps" || $REPO = "vendor_google_gms" ]]; then
    GITHOST=gitlab
    ORG=AOSPK
  fi
  if [[ $REPO = "www" ]]; then
    ORG=AOSPK
    BRANCH=master
  fi
  if [[ $REPO = "build_make" ]]; then
    REPO=build
  fi
  if [[ $REPO = "packages_apps_PermissionController" ]]; then
    REPO=packages_apps_PackageInstaller
  fi
  if [[ $REPO = "vendor_qcom_opensource_commonsys-intf_bluetooth" ]]; then
    REPO=vendor_qcom_opensource_bluetooth-commonsys-intf
  fi
  if [[ $REPO = "vendor_qcom_opensource_commonsys-intf_display" ]]; then
    REPO=vendor_qcom_opensource_display-commonsys-intf
  fi
  if [[ $REPO = "vendor_qcom_opensource_commonsys_bluetooth_ext" ]]; then
    REPO=vendor_qcom_opensource_bluetooth_ext
  fi
  if [[ $REPO = "vendor_qcom_opensource_commonsys_packages_apps_Bluetooth" ]]; then
    REPO=vendor_qcom_opensource_packages_apps_Bluetooth
  fi
  if [[ $REPO = "vendor_qcom_opensource_commonsys_system_bt" ]]; then
    REPO=vendor_qcom_opensource_system_bt
  fi

  if [[ ${1} = "gerrit" ]]; then
    echo "${BOL_BLU}Pushing to gerrit.aospk.org/${GRE}${ORG}${END}/${BLU}${REPO}${END} - ${BRANCH} ${RED}${FORCE}${END}"
    if [ -z "${TOPIC}" ]
    then
      git push ssh://kleidione@gerrit.aospk.org:29418/${REPO} HEAD:refs/for/${BRANCH}
    else
      git push ssh://kleidione@gerrit.aospk.org:29418/${REPO} HEAD:refs/for/${BRANCH}%topic=${TOPIC}
    fi
  else
    echo "${BOL_BLU}Pushing to ${GITHOST}.com/${GRE}${ORG}${END}/${BLU}${REPO}${END} - ${BRANCH} ${RED}${FORCE}${END}"
    git push ssh://git@${GITHOST}.com/${ORG}/${REPO} HEAD:refs/heads/${BRANCH} ${FORCE}
  fi
}

sideload() {
  pathBuilds=/home/kleidione/Source/kraken/out/target/product/vayu/
  buildHour=${1}
  if [ "${pathBuilds}" ]; then
    zipPath=$(ls -tr "${pathBuilds}"/Kraken-12-*-*-${buildHour}-vayu*.zip | tail -1)
    if [ ! -f $zipPath ]; then
      echo "Nenhuma build"
      return 1
    fi
    echo "Esperando dispositivo responder o adb..."
    adb wait-for-device-recovery
    echo "Dispositivo encontrado"
    if (adb shell getprop ro.kraken.device | grep -q "$CUSTOM_BUILD"); then
      echo "Reiniciando"
      adb reboot sideload-auto-reboot
      adb wait-for-sideload
      adb sideload $zipPath
    else
      echo "O dispositivo conectado não parece ser $ CUSTOM_BUILD"
    fi
      return $?
  else
      echo "Nenhuma build"
      return 1
  fi
}

