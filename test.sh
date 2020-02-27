#!/data/data/com.termux/files/usr/bin/bash
#获取自身绝对路径
echo $(cd `dirname $0`; pwd)
echo $(dirname $(readlink -f $0))
echo $(cd $(dirname ${BASH_SOURCE:-$0});pwd)
echo $(dirname $(readlink -f ${BASH_SOURCE[0]}))
echo "${0##*/}"
echo "$(cd $(dirname ${BASH_SOURCE:-$0});pwd)"
echo "Error:$(dirname $(readlink -f ${BASH_SOURCE[0]}))"/"${0##*/}"

