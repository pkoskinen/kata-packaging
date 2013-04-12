#! /bin/sh
#set -x
#set -v

tmpfile=/tmp/$(basename $0)-$(date "+%s")-$RANDOM
infofile=version.info

function git_available {
  git rev-parse HEAD >/dev/null 2>/dev/null
  status=$?
  case $status in
    0)
      echo "cwd in inside git repo"
      retval=0
      ;;
    127)
      echo "git not installed"
      retval=1
      ;;
    128)
      echo "git installed, but cwd not inside repo"
      retval=1
      ;;
    *)
      echo "unexpected return code inside function git_available"
      retval=2
      ;;
  esac
  return $retval
}

if git_available >$tmpfile
then
  echo '$ git rev-parse HEAD'
  git rev-parse HEAD 
  echo '$ git status'
  git status
else
  

   
