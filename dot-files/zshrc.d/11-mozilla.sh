# mozilla
alias phab="moz-phab"
alias review="mach lint -o && moz-phab submit"
alias w="TASKCLUSTER_ROOT_URL=https://firefox-ci-tc.services.mozilla.com watch-task"

function phabimport {
  wget https://phabricator.services.mozilla.com/${1}\?download\=true -qO - | hg import - --no-commit
}

tf () {
  fx "tg => String(require(\"child_process\").spawnSync(\"fzf\", [\"-f\", \"$1\"], {\"input\": Object.keys(tg).join(\"\n\")}).output).split(\"\n\").reduce((obj, key) => { obj[key] = tg[key]; return obj; }, {})" | fx
}

tc-signin () {
    if [[ "$#" == "0" ]]; then
        echo "error: must provide use case"
        return 1
    fi
    purpose="$1"
    shift

    case $purpose in
        ciadmin)
            expiry="60m"
            scopes=(
                "hooks:list-hooks:*"
            )
            ;;
        relduty)
            expiry="60m"
            scopes=(
                "queue:rerun-task:*"
                "queue:cancel-task:*"
            )
            ;;
        hook)
            expiry="15m"
            scopes=(
                "hooks:trigger-hook:*"
            )
            ;;
        root)
            expiry="15m"
            scopes=(
                "*"
            )
            ;;
        *)
            echo "error: invalid use case '$purpose'"
            return 1
    esac

    scope_str=$(IFS=$'\n' ; echo "${scopes[*]}")
    tc_url="${TASKCLUSTER_ROOT_URL:-https://firefox-ci-tc.services.mozilla.com}"
    eval "$(TASKCLUSTER_ROOT_URL=$tc_url taskcluster signin --expires=$expiry --scope="$scope_str")"
}

tc-signout () {
    unset TASKCLUSTER_CLIENT_ID
    unset TASKCLUSTER_ACCESS_TOKEN
}

rerun-task-group () {
    taskcluster group list -f $1 | grep $2 | cut -d" " -f1 | xargs -n1 taskcluster task rerun
}

export ANDROID_SDK_ROOT='/usr/lib/android-sdk'
export GECKO=$HOME/dev/mozilla-unified
export MACHRC=$HOME/.machrc
export TASKCLUSTER_ROOT_URL=https://firefox-ci-tc.services.mozilla.com

# turn on mozilla data collection
export BUILD_SYSTEM_TELEMETRY=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ahal/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ahal/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ahal/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ahal/opt/google-cloud-sdk/completion.zsh.inc'; fi

GPG_TTY=$(tty)
export GPG_TTY

mac_signing_hosts=()
for i in {1..3} {7..9} {14..17} {19..20}
do
    mac_signing_hosts+=("mac-v3-signing$i.srv.releng.mdc1.mozilla.com")
done

dep_mac_signing_hosts=()
for i in 1 3
do
    dep_mac_signing_hosts+=("dep-mac-v3-signing$i.srv.releng.mdc1.mozilla.com")
done

vpn_mac_signing_hosts=()
for i in 18
do
    vpn_mac_signing_hosts+=("vpn-mac-v3-signing$i.srv.releng.mdc1.mozilla.com")
done

tb_mac_signing_hosts=()
for i in 1 3
do
    tb_mac_signing_hosts+=("tb-mac-v3-signing$i.srv.releng.mdc1.mozilla.com")
done

all_mac_signing_hosts=( "${mac_signing_hosts[@]}" "${dep_mac_signing_hosts[@]}" "${vpn_mac_signing_hosts[@]}" "${tb_mac_signing_hosts[@]}" )

signer-login () {
    if ! ssh-add -l | grep -q "ahal@DESKTOP-BF76SPQ"; then
        ssh-add ~/.ssh/ahal-xps
    fi
    hosts=("$@")
    for host in "${hosts[@]}";
    do
        echo "Logging into $host"
        ssh "ahalberstadt@$host" -f "exit"
        sleep 10
    done
}

git-mozilla-clone () {
    org="$1"
    repo="$2"
    git clone "git@github.com:ahal/$repo.git" "/home/ahal/dev/$repo"
    git remote add mozilla "git@github.com:$org/$repo.git"
    git pull mozilla
}
