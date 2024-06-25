#! /bin/bash

red=0
green=0
total=0

rm -f wc357 uniq357 out_* test_*

if [ "$1" = "valgrind" ]; then

  gcc word_count.c -o wc357
  if [ $? -ne 0 ]; then
    echo "ERROR: unable to compile word_count.c"
    exit 1
  fi

  gcc uniq.c -o uniq357
  if [ $? -ne 0 ]; then
    echo "ERROR: unable to compile uniq.c"
    exit 1
  fi
    
  if ! command -v valgrind &> /dev/null ; then
    echo "Installing valgrind..."
    sudo apt-get -yq update > /dev/null
    sudo apt-get -yq install valgrind > /dev/null
    echo "Done installing valgrind"
  fi
  
  ((total++))
  rm -f out_valgrind
  timeout 2s valgrind --leak-check=full ./wc357 word_count.c 2>&1 | grep "ERROR SUMMARY" | cut -d' ' -f4-5 > out_valgrind
  diff -yw <(echo "0 errors") out_valgrind
  if [ $? -ne 0 ]; then
    ((red++));
    echo "ERROR: word_count valgrind"
  else
    echo "SUCCESS: word_count valgrind"
    ((green++));
  fi

  ((total++))
  rm -f out_valgrind
  timeout 2s valgrind --leak-check=full ./uniq357 uniq.c 2>&1 | grep "ERROR SUMMARY" | cut -d' ' -f4-5 > out_valgrind
  diff -yw <(echo "0 errors") out_valgrind
  if [ $? -ne 0 ]; then
    ((red++));
    echo "ERROR: uniq valgrind"
  else
    echo "SUCCESS: uniq valgrind"
    ((green++));
  fi

elif [ "$1" = "wc" ]; then
    
  ((total++))
  gcc word_count.c -o wc357 && echo -e "a aa\nbbbb\nc\n\naaa, 123\n" > test_wc1
  wc test_wc1 | awk '{print $1,$2,$3}' > out_expected
  timeout 2s ./wc357 test_wc1 > out_actual && diff -y --suppress-common-lines out_actual out_expected
  if [ $? -ne 0 ]; then
    echo "ERROR: wc1 (actual / expected shown above)"
    ((red++));
  else
    echo "SUCCESS: wc1"
    ((green++));
  fi

  rm -f out_* test_*

  ((total++))
  gcc word_count.c -o wc357 && echo -e "a aa\nbbbb\nc\n\naaa, 123\n" > test_wc1
  wc < test_wc1 | awk '{print $1,$2,$3}' > out_expected
  timeout 2s ./wc357 < test_wc1 > out_actual && diff -y --suppress-common-lines out_actual out_expected
  if [ $? -ne 0 ]; then
    echo "ERROR: wc1 stdin (actual / expected shown above)"
    ((red++));
  else
    echo "SUCCESS: wc1 stdin"
    ((green++));
  fi

  rm -f out_* test_*

  ((total++))
  wc word_count.c | awk '{print $1,$2,$3}' > out_expected
  timeout 2s ./wc357 word_count.c > out_actual && diff -y --suppress-common-lines out_actual out_expected
  if [ $? -ne 0 ]; then
    echo "ERROR: wc2 (actual / expected shown above)"
    ((red++));
  else
    echo "SUCCESS: wc2"
    ((green++));
  fi

  rm -f out_* test_*

  ((total++))
  echo -e "\n" > test_wc2
  wc test_wc2 | awk '{print $1,$2,$3}' > out_expected
  timeout 2s ./wc357 test_wc2 > out_actual && diff -y --suppress-common-lines out_actual out_expected
  if [ $? -ne 0 ]; then
    echo "ERROR: wc3 (actual / expected shown above)"
    ((red++));
  else
    echo "SUCCESS: wc3"
    ((green++));
  fi


elif [ "$1" = "uniq" ]; then

  gcc uniq.c -o uniq357

  rm -f out_* test_*

  ((total++))
  echo -e "a\naa\naa\naa\nb\naa\na" > test_uniq1
  uniq test_uniq1 > out_expected
  timeout 2s ./uniq357 test_uniq1 > out_actual
  diff -y --suppress-common-lines out_actual out_expected
  if [ $? -ne 0 ]; then
    echo "ERROR: uniq1 (actual / expected shown above)"
    ((red++));
  else
    echo "SUCCESS: uniq1"
    ((green++));
  fi

  rm -f out_* test_*

  ((total++))
  echo -e "a\naa\naa\naa\nb\naa\na" > test_uniq1
  uniq < test_uniq1 > out_expected
  timeout 2s ./uniq357 < test_uniq1 > out_actual
  diff -y --suppress-common-lines out_actual out_expected
  if [ $? -ne 0 ]; then
    echo "ERROR: uniq1 stdin (actual / expected shown above)"
    ((red++));
  else
    echo "SUCCESS: uniq1 stdin"
    ((green++));
  fi


  rm -f out_* test_*

  ((total++))
  uniq uniq.c > out_expected
  timeout 2s ./uniq357 uniq.c > out_actual
  diff -y --suppress-common-lines -Z out_actual out_expected
  if [ $? -ne 0 ]; then
    echo "ERROR: uniq2 (actual / expected shown above)"
    ((red++));
  else
    echo "SUCCESS: uniq2"
    ((green++));
  fi

  rm -f out_* test_*

  ((total++))
  echo -e "a\na\na\na\n\naa\naa\na\na\n" > test_uniq3
  uniq test_uniq3 > out_expected
  timeout 2s ./uniq357 test_uniq3 > out_actual
  diff -y --suppress-common-lines out_actual out_expected
  if [ $? -ne 0 ]; then
    echo "ERROR: uniq3 (actual / expected shown above)"
    ((red++));
  else
    echo "SUCCESS: uniq3"
    ((green++));
  fi

elif [ "$1" = "style" ]; then

    wget -q https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl
    #perl checkpatch.pl --no-signoff --types BRACKET_SPACE,ASSIGN_IN_IF,DEEP_INDENTATION,TRAILING_STATEMENTS -f --no-tree *.c
    
    perl checkpatch.pl --terse --ignore STRCPY,CODE_INDENT,LEADING_SPACE,TRAILING_WHITESPACE,OPEN_BRACE,BRACES,SPDX_LICENSE_TAG -f --no-tree *.c

    if [ $? -ne 0 ]; then
	echo "ERROR: style check"
	((red++));
    else
	echo "SUCCESS: style check"
	((green++));
    fi
    
else

    echo "No test specified"
    exit 1

fi


echo $green out of $total tests passed

if [ $red -ne 0 ]; then
    exit 1
else
    exit 0
fi
