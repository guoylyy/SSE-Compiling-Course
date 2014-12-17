#!/usr/local/bin/python
# mkrun.py
#
# Author: Globit Allen (yiliangg@foxmail.com)
# Date  : Dec 16, 2014
#
# Converts a Markdown simple file into a DOM tree
# specification.   To use, simply do this:
#
#   % python mkrun.py [-lex|run] inputfile.md > index.html
#
# Disclaimer:  This is just a simple for referencing which i make
# in affternoon.It might have some bugs. However, it work well when
# I tried in my maxosx system with 2.76 python run time evironment.
#
import sys
import os
from ply import *

from mklex import *
from mkyacc import *

import ply.yacc as yacc
yacc.yacc()

def is_file_exist(filename):
	pass

if __name__ == '__main__':
	if len(sys.argv) != 3:
		print "usage : mkrun.py [-lex|run] inputfilename"
		raise SystemExit 

	if len(sys.argv) == 3:
		if sys.argv[1] == '-lex':
			mklex_run(sys.argv[2])
		elif sys.argv[1] == '-run':
			yacc.parse(open(sys.argv[2]).read())
