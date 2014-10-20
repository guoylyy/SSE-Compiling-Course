
##windows配置lex说明文档
金XX

现在我来介绍如何在win下配置Lex环境：

##基本知识：
Lex是Unix上的软件，基本环境与win不同，所以在win下用Lex应
有基本的两个思路：

* 在win下配置unix/linux的模拟环境，在该模拟环境下使用lex
* 使用lex在win下的移植软件

##配置方法：
* 首先来介绍第2种方法也是最简单的方法：使用lix在win下的移植软件

    win下的的移植软件和unix下的lex的一个实现flex一样，也叫做flex
    
    分流下载地址：http://pan.baidu.com/s/1dDD0O2d 
        ps:该共享目录下还有bison(语法分析器)在win下的移植软件及带gcc编译器的IDE：code::blocks
    环境搭配步骤：
    * 下载文件  flex-2.5.4a-1.exe
    * 安装至任意目录
            (例如 D:\GunWin32)
    * 安装完成！

    好了你现在已经把lex的环境搭配好的，厉害吧233333
    
    我是认真的 你现在真的已经搭配好了
    因为现在你已经可以吧 xx.l 文件 通过 lex 编译成 xx.yy.c 文件了
    
    步骤如下：
    * 把一个 xx.l文件放到 刚才安装目录下的 bin目录下
            (例如 把助教上传的 simple-test.l 文件放在 D:\GunWin32\bin下)
    * 打开cmd 切换目录到 bin 目录下
            (例如 在cmd中输入
            d:
            cd D:\GunWin32\bin)
    * 输入编译命名 flex xx.l
            (如：
            flex simple-test.l)
    * 然后就会生成一个lex.yy.c文件。这个文件就是通过lex生成的c的源文件
            (ps：可以把bin目录加入到环境变量当中，然后就可以在任意目录输入flex xx.l文件编译成.c的源文件了)
    
    现在我们已经拥有.c文件了，编译这个.c文件就可以得到执行文件exe了
    
    但是不幸的是 vs的编译器并不能编译这个.c文件，只能在gcc的编译器下才能执行编译
    
    所以如果你的电脑上已经有gcc编译器话，就可以直接编译出可执行文件运行了，
    但是没有gcc编译器的话，还需要配置gcc编译器环境
    
    大家都不喜欢用命令行编译文件，所以我这里推荐一个win下带gcc编译器的
            IDE:codeBlocks
            （codeBlocks可以在我刚才上传的文件夹内下载）
    
    安装好codeBlocks, 将刚才的.c文件拖入 codeBlocks 中，点击菜单的 build->build(或 ctrl+f9)
    然后就会在刚才的目录下编译出可执行文件
    
    直接双击或在cmd中打开，就可以输入字母进行识别了。



##在模拟unix环境下配置lex
这里的模拟不是指虚拟机，而是在win下产生一个unix的编译环境，然后以unix的方式处理编译文件。但是总体来说，这是一个模拟环境，编译速度很慢，不推荐使用

方法有很多种，这里先推荐使用cygwin

        下载地址：
    这里上传的是一个离线包，可能不是最新的版本。需要最新的版本可以直接去官网下载setup.exe但是这个是一个在线安装的软件，需要在线安装，速度有点慢
    
在任意目录安装完成后(如： D:\cygwin)，会在桌面上生成一个快捷方式，双击就可以进入unix编译模拟环境

如果进入更目录(D:\cygwin)可以发现一个 home文件夹(D:\cygwin\home)

home文件夹下是计算机当前账户的名字如(Administrator)命名的文件夹(D:\cygwin\home\Administrator)

一般可把这个目录当做工作目录(熟悉linux的应该看到就知道是什么了···)

点击刚才的快捷方式进入unix编译环境会发现命令行指代了一个当前目录

        (如 Administrator@XXX ~
            这个目录指代的就是刚才所说的D:\cygwin\home\Administrator)

然后cygwin就配置完成了。

但是这个cygwin在编译lex的时候缺少一些必须组件，必须先装上一个叫做autotools的组件

        下载地址：