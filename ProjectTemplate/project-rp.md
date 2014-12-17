# 编译原理大作业

---
@author: globit

@date : 2014-12-16

---

本文档是同济大学 2014 年大三上学期编译原理课程的课程大作业，作业目标是用 lex、yacc 工具完成 markdown 的语言解析，培养在实际编程中实现编译原理思想的能力，深化对编译原理的理解。

## 1. 作业需求

### 1.1 技术需求

作业的要求是：

**通过python 编译原理库 pyLex 和 pyYACC 完成一个 Markdown 的解析器，解析器主要负责读取一篇 Markdown 文档，然后通过语法和词法解析，进而构建语法树，然后生成一个 HTML DOM 树。**

[Markdown标准](http://daringfireball.net/projects/markdown/syntax)

[Markdown标准zh](http://wowubuntu.com/markdown/)

听起来是不是很简单啊，所以看到这里，大神们就要问题来了—— 如何体现我的牛逼呢？ 这里我建议大家仔细看一下 Markdown 的语法，其实要支持所有的语法是很难的，所以我这里把项目的实现分成几个级别，以区别大神和小白，当然，只要达到最低级别就可以及格了。

* LV1 初见成效:  完成测试文件 test01.md 的dom生成  //及格线
* LV2 小有所成:  完成测试文件 test02.md 的dom生成  //平均线
* LV3 驾轻就熟:  完成测试文件 test03.md 的dom生成
* LV4 水到渠成:  自行想一些扩展需求或者是给的test文件中没有涉及到的复杂语法，如代码着色，效率优化等，实现功能，允许使用第三方库，这是加分项，实现后务必在项目文档中描述清楚如何实现、如何使用。

```测试用的test0x.md 文件在项目模板文件夹下的 requirements 文件夹中```

### 1.2 组队和操作流程

组队配置要求如下：

```
团队成员： 1 ~ 3 人
组队方式：自由组队（可以跨班级组队）
```

#### 1.2.1 组队信息提交模板

```
to: yiliangg@foxmail.com
from: xxx@xxx.com

project: [组队提交][1334903-郭意亮-3人组]

hi xxx的助教：
    组队编号：1334903
    队员信息：
      1. xxx   133413
      2. xxx   413123
    我是组长xxxx，我的电话是：xxxxx
    
```

### 1.3 作业提交相关

**高能预警：作业提交日期为 —— 2015年X月X日晚12点前,之后每晚一天扣除5%的实验分数，一直到为0为止。**

####1.3.1 项目相关文件

##### 1.3.1.1 文档
文档 **(readme.md)** 位于项目模板文件夹下，请按照模板要求填写,其中有一栏小组成员分工要说明下。

###### 小组成员分工

一下两种情况都需要提供，如果使用其他 git 平台请截图放在项目文件夹内一起提交。

1. 提交小组成员分工说明
	* 由组长填写，其他成员确认。
2. 提交小组成员的代码提交记录(github 项目提交我会看项目的commit 记录)
	* github commit 记录 （所有 commit 的comments 要写详细一些）


##### 1.3.1.2 代码
代码提交采用两种方式，可以选择适合你们小组的方式。

1. *github* 提交，直接邮件助教链接，模板请 fork 主项目
2. *邮件* 提交，同样采用项目模板，打包邮件发送

#### 1.3.2 邮件提交相关信息

##### github submit
```
to: yiliangg@foxmail.com
from: xxx@xxx.com

project: [作业提交][1334903-郭意亮-3人组]

hi xxx的助教：
    我们组的 github 项目链接为： http://www.github.com/caonima/
    我确保一切都已经准备完毕，请检验。
    我的电话是：xxxxx
```

#### attachment submit
```
to: yiliangg@foxmail.com
from: xxx@xxx.com

project: [作业提交][1334903-郭意亮-3人组]

hi xxx的助教：
    我们组的项目已经打包在附件，请检验。
    我确保一切都已经准备完毕，请检验。
    我的电话是：xxxxxxxx
    
```

## 2. 作业引导

### 2.1 环境配置

建议还是采用 python2.7x 版本

####2.1.1 windows python 环境配置

详情参见：

####2.1.2 linux、macosx python环境

这两种系统的用户基本不需要配置 python 环境，如果实在遇到问题自行百度谷歌之，很好解决的。

### 2.2 ply安装
任何操作系统，进入ply 目录（ProjectTemplate）中的lib文件夹中有下载了相应的包，解压就可以了，解压之后就可以用已经安装好的python库安装了。
然后，进入ply目录

```
python setup.py install
```

### 2.2 软件使用

请参考视频和后面参考材料中的链接。

### 2.3 助教给的基础例子测试

直接 git clone 下来用吧，git怎么用看后面的参考资料中 [git guide](http://rogerdudler.github.io/git-guide/index.zh.html).

```
cd ProjectTemplate/sample
python run.py test.md
```

这三步完成之后，就自己发挥把。

## 3. 参考材料

### 3.1 ply lex yacc
* [Python Lex Yacc手册](http://www.pchou.info/open-source/2014/01/18/52da47204d4cb.html)
* [ Python语法解析器PLY——lex and yacc in Python](http://blog.csdn.net/chosen0ne/article/details/8077880)

### 3.2 python相关
* [python 在线编程平台](http://www.codeskulptor.org/)
* [简明 python 教程](http://woodpecker.org.cn/abyteofpython_cn/chinese/)
* [python code style](http://www.python.org/dev/peps/pep-0008/)
* [python从入门到不精通教程 - 助教乱写的](http://blog.yiliang.me/%E7%A8%8B%E5%BA%8F%E8%AF%AD%E8%A8%80/2014/05/09/python-introduction.html)

### 3.3 git 相关
* [git guide](http://rogerdudler.github.io/git-guide/index.zh.html)



