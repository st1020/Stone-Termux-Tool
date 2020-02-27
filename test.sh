#!/data/data/com.termux/files/usr/bin/bash
#获取自身绝对路径
echo 1：$(cd `dirname $0`; pwd)
echo 2：$(dirname $(readlink -f $0))
echo 3：$(cd $(dirname ${BASH_SOURCE:-$0});pwd)
echo 4：$(dirname $(readlink -f ${BASH_SOURCE[0]}))
echo "5：${0##*/}"
echo "6：$(cd $(dirname ${BASH_SOURCE:-$0});pwd)"
echo "7：Error:$(dirname $(readlink -f ${BASH_SOURCE[0]}))"/"${0##*/}"

