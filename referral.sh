#!/bin/bash

OUTPUT_FILENAME='bcdice_naming.csv'

bundle exec referral \
  --column=file,line,column,type,scope,name \
  --type=module,class,constand_def,class_method,instance_method,local_var_assign,instance_var_assign,class_var_assign,global_var_assign \
  --delimiter="," \
  --print-headers \
  vendor/BCDice/src/{,{dice,diceBot,utils}/}*.rb \
  > $OUTPUT_FILENAME

echo $OUTPUT_FILENAME
