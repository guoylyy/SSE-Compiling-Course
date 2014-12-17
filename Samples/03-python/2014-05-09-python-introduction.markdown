---
layout: post
title: "python从入门到不精通教程"
categories: 程序语言
---

本文档适合Python新手阅读，无论有没有编程经验都无所谓，特别需要注意的是本文档尤其适合在蹲马桶的时候进行阅读，**人生苦短，我用Python**.

###1. 初出茅庐
我们先来看看一些Python代码的例子。

####1. 缩进
提到代码结构，Python语言是十分规整的，尤其是对于各种有洁癖处女座的小受，当然也适合粗中有细的彪形大汉，可以说居家旅行必备之良品，闲话少扯，开始看一段典型的Python代码：

{% highlight python %}
if man_jack is "小受"：
	man_jack.couple(man_gong)
else:
	pass
{% endhighlight %}

你没有看错，代码结构就是这个销魂，这里没有大括号({})，只有tab tab tab，学过编译原理的童鞋们应该明白，这种结构可以用来生成语法树。所以，你只要记住，每当你想要代码“包裹”后面代码的时候，勇敢按下tab吧，少年，你可以的。

####2.代码风格

>Programs must be written for people to read, and only incidentally for machines to execute.

代码风格是很重要的，当你注意你的代码风格并不断把美好的代码应用在程序中的那一刻，你已经不再是一个程序员，你是计算机之美的搬运工。
具体的代码风格多种多样，如果非要找出一个比较全面而且最好的，我推荐刚开始学习的时候就使用[Google Python编码规范](http://zh-google-styleguide.readthedocs.org/en/latest/google-python-styleguide/python_style_rules/)


###2. 打怪练习
本小节主要讲Python编程中经常会用到的数据结构和相关的基本特征，那么带着系统给的桃木剑开始在主城门口打怪吧。

####1. 变量
Python因为是动态脚本语言，所以对变量的要求比较弱，意思就是我们可以任意使用变量，在初学阶段可以暂时不用过多考虑变量的类型，你给什么就是什么被。

{% highlight python %}
 a_int = 1 
 a_str = "2"
 print a_int
{% endhighlight %}


####2. 数组
编程中用得最频繁的应该就是数组了，python的数组非常好用，一旦拥有，别无所求，下面来看看吧：

{% highlight python %}
l = ['a','b','c']
l = l + ['d']  #两个数组相加，猜猜结果？

foreach ele in l: #遍历
	print ele

split1 = l[0:1]
split2 = l[:3]
split3 = l[1:-1]

l.append('e')
del l[1]
del l[1:3]

freshfruit = [' banana', ' loganberry ', 'passion fruit ']
[str.strip() for str in freshfruit] 
{% endhighlight %}

####3. dict字典
python里的字典就像java里的HashMap，以键值对的方式存在并操作，其特点如下：

{% highlight python %}
table = {'abc':1, 'def':2, 'ghi':3}   
table['abc']   

foreach key in table.keys():
	print(table[key])

table.values() 

table['abc'] = table
{% endhighlight %}

还有一个元组就不介绍了，自行可以学习。

####4. 读文件
读文件非常简单，见代码：

{% highlight python %}
myfile = open('myfile', 'r')   
myfile.readline()   
{% endhighlight %}

###3. 牛刀小试
恭喜你，少年，你已经在城门口打怪做任务经受住了组织的考验，现在可以进入下一个level的学习了，这个小节中你可以学习到一些python在实际编程任务场景中的用法，应该怎么做不应该怎么做，一定要认真学习饿。

{% highlight python %}
import datetime  #导入库
import simplejson as json ＃导入库并起一个外号

datetime.datetime.now
json.dumps('{"result":"success"}') #这里就可以直接叫外号了

{% endhighlight %}

如果不幸你的环境中缺少了某种库，请自行到[python官网](http://legacy.python.org)下载安装。

{% highlight python %}
import os
import time

def make_dir(path):
	if not os.path.exists(path):
		os.mkdir(path)
		print 'Successfully created directory ', path

source = ['/home/globit/study','/home/globit/projects/gitFiles/']	

target_dir = '/home/globit/tem/backup'
make_dir(target_dir)

today = target_dir + '/' + time.strftime('%Y%m%d%H%M%S')

now = time.strftime('%H%M%S')

make_dir(today)

comment = raw_input('Enter a comment ->')

if len(comment) == 0:
	target = today + os.sep + now + '.zip'
else:
	target = today + os.sep + now + '_' + comment.replace(' ','_') + '.zip'


zip_command = "zip -qr '%s' %s" % (target, ' '.join(source))

#pddrint zip_command

if os.system(zip_command) == 0:
    print 'Successful backup to', target
else:
    print 'Backup FAILED'

{% endhighlight %}

以上是一个备份的程序，加油少年，之所以不给注释是让你自己看懂它，如果能看懂，基本上你已经入门了，稍加栽培前途不可限量，我手头有一门如来神掌........


###4. 剑谱汇总

总结了一些对于初学者而言比较有用的Python资料，资源都来自网络。

* [简明python教程](http://woodpecker.org.cn/abyteofpython_cn/chinese/)
* [笨方法学python](http://www.2cto.com/shouce/Pythonbbf/index.html)
* [CodeSkulptor](http://www.codeskulptor.org/) 在线python编程环境
* [深入python3](http://woodpecker.org.cn/diveintopython3/index.html)
* [和孩子一起学编程](http://pan.baidu.com/s/1i3eHVIt)
* [python标准库](http://pan.baidu.com/s/1GPUiE)
* [Google Python编码规范](http://zh-google-styleguide.readthedocs.org/en/latest/google-python-styleguide/python_style_rules/)
