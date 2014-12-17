import datetime
#
# 1. variables
#
va = 1
va01 = 'test'
vc = [1,3,4,'4']
print va 
if va == 1:
	print 'a is %s' % (va)

print 'this is %d,%d,%d,%s' % (1,3,4,'ss')

# file read
filename = 'test.md'
f = open(filename,"r+")
for line in f.readlines():
	print line

now = datetime.datetime.now()
print now
print now.timetuple()

print dir(now)

#
# 2. list tuple and map
#

# list
t_list = [1,'3','five','7777','999']
t_list.sort()
print t_list
#split 




