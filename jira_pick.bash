echo "      _ _____ _____              _____ _____ _____ _  __"
echo "     | |_   _|  __ \     /\     |  __ \_   _/ ____| |/ /"
echo "     | | | | | |__) |   /  \    | |__) || || |    | ' / "
echo " _   | | | | |  _  /   / /\ \   |  ___/ | || |    |  <  "
echo "| |__| |_| |_| | \ \  / ____ \  | |    _| || |____| . \ "
echo " \____/|_____|_|  \_\/_/    \_\ |_|   |_____\_____|_|\_\ "
echo ""
echo "[STATUS] Checking git connection..."

if ! git ls-remote >/dev/null 2>&1; then
    echo "ERROR!"
    exit 1
fi

echo "[STATUS] Git connection: OK!"
echo ""
echo ""
echo "> Please enter the jira card that you want to filter to cherry-pick"
read JIRA_CARD
echo ""
echo "> Please enter the central branch of this card"
read CENTRAL_BRANCH
echo ""
echo "> Auto merge option theirs (accept all comming changes) | ours (accept all current changes) | manually [safe] (no merge option manually conflict treatment)"
options=("theirs" "ours" "manually")
select opt in "${options[@]}"
do
    case $opt in
        "theirs") break;;
        "ours") break;;
        "manually") break;;
        *) echo "invalid option $REPLY";;
    esac
done
echo ""
commits=$(git log $CENTRAL_BRANCH --format=format:%H --no-merges --grep=$JIRA_CARD --reverse)
i=1
for commit in $commits; do
    echo "$i) $commit"
    i=$((i+1))
done
echo ""
echo "Awaiting for your confirmation to cherry-pick the commits above... [Y/N]"
read $confirmation
if [[ $confirmation != "Y" ]] || [[ $confirmation != "y" ]]; then
    echo "[STATUS] Cherry-picking aborted!"
    exit 1
fi

for commit in $commits; do
    cp=$(git cherry-pick $commit -X $opt)
    if [[  $cp =~ "CONFLITO"  ]] || [[  $cp =~ "error"  ]] || [[  $cp =~ "CONFLICT"  ]]; then
        echo "[STATUS] Resolve conflicts then press any key"
        read -rsn1
        git cherry-pick --continue
    else
        echo "[STATUS] Success $commit"
        echo "------------------------------------------------------"
    fi
done
