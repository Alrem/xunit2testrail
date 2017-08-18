#!/bin/bash
test $DEBUG && set -x && CMD='echo'

if ! [ -a  $REPORT ]; then
  echo "$REPORT is not founded"
  exit 1
fi

if ! [ $PASS ]; then
  echo 'Password ($PASS) is not exported'
  exit 1
fi

DATE=`date +%Y%m%d`

if ! [ $TEST_GROUP ]; then
  TEST_GROUP="${SHORT_TEST_GROUP}.$DATE"
fi


$CMD report -v \
--testrail-plan-name "$TESTRAIL_PLAN_NAME" \
--env-description "$TEST_GROUP" \
--testrail-url  "$TESTRAIL_URL" \
--testrail-user "$TESTRAIL_USER" \
--testrail-password "$PASS" \
--testrail-project "$TESTRAIL_PROJECT" \
--testrail-milestone "$TESTRAIL_MILESTONE" \
--testrail-suite "$TESTRAIL_SUITE" \
--testrail-name-template '{title}' \
--xunit-name-template '{classname}.{methodname}' $REPORT

EXIT_CODE=$?
echo "----------------------------------------------------------"
echo "---------- Report has finished with exit code $EXIT_CODE ----------"
echo "----------------------------------------------------------"
test $DEBUG && /bin/bash || exit $EXIT_CODE
