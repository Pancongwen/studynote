# 管理代码环境

## 本文环境
本文涉及一些 `shell` 命令，测试时均基于以下环境。
1. 操作系统 ： ubnutu 16.04 
2. 命令行 ： bash


## 为什么要管理环境？
首先，先来想象一下以下场景：
1. 安装了有缺陷的解释器，一运行就报错。
2. 安装了错误版本，运行代码时发现版本不匹配。
3. 编写项目时，项目A需要语言版本a，项目B需要语言版本b。
4. 开发结束后，需要交付依赖文档时，记不清开发过程中安装过哪些依赖。
5. 两个项目依赖有冲突，每次开发都需要调整某些依赖。

ps： 更多场景欢迎补充。

这些场景在探索和学习代码时应该都遇到过，如果没有代码环境管理上知识，一般会这么做：  
1. 如果报错信息看懂了，那么直接解决问题。
2. 如果不清楚报错信息所指，打开 `baidu` 或者 `google`，粘贴报错信息进行搜索。
3. 找到一些 `CSDN` 等博客的文章，或者 `zhihu`，`Stack Overflow` 等网站上的问题。
4. 根据文章或问题进行试验，如果解决了就结束。如果没解决换下一篇。（其实这里经常会埋下隐患：改了一些东西，却没有进行恢复。）
5. 如果没有试验出解决方案，则向身边大神寻求帮助或者求助于问题平台或者论坛。（这个步骤会拉长解决问题的周期。）

这个解决步骤很繁琐，特别是当你持续遇到类似问题时。如果是学习，会导致兴致下降或者放弃。如果是工作，则会使效率下降，拖慢进度。而且在第 4 步时候，个人回栈能力（即思路马上回到上一个已验证的节点）比较弱时，思路会不清晰。

现在我们再看一下场景，整理一下环境管理器需要满足什么条件（以下编号与场景编号对应）：
1. 经过测试的安装包。
2. 能够指定下载版本。
3. 每个项目都可以指定版本。
4. 能够列出当前项目的依赖名。
5. 将一些依赖做成局部而不是全局依赖。

## 准备工作  
  
现在有许多环境管理的软件，本文介绍一个开源软件： `conda` 。官网介绍看[这里](https://conda.io/docs/)。  
`conda` 可以做环境管理，也可以做包管理工具，上方的条件也都能够满足。

### 下载
首先，我们下载 `Anaconda`。下载链接在[这里](https://www.anaconda.com/download/#linux)。  
根据操作系统、对应的处理器位数和 `python` 版本选择安装包，本文选择的是 `linux`、`64bit` 和 `python3.6`。下方安装部分也已此安装包为例。

### 安装
1. 成功下载好后，使用 `MD5` 或 `SHA-256` 检测下载的数据包是否正确。
    ```bash
    md5sum /path/filename
    ```
    或者
    ```bash
    sha256sum /path/filename
    ```
    使用刚刚下载好的文件路径替换掉 `/path/filename`，文件一般会下载在 `~/Download/` 文件夹下。

2. 执行安装脚本。
    ```bash
    cd ~/Downloads
    bash Anaconda3-5.2.0-Linux-x86_64.sh
    ```
    或者
    ```bash
    cd ~/Downloads
    chmod +x Anaconda3-5.2.0-Linux-x86_64.sh
    ./Anaconda3-5.2.0-Linux-x86_64.sh
    ```
    下载下来的安装文件是没有可执行权限的
    
3. 根据安装脚本的提示进行配置。  
    * 首先，按 `Enter` 继续。
    * 下面会展示 `Licence`、`Notice` 之类的，一直按 `Enter` 直到出现：
    ```bash
    Do you accept the license terms?[yes|no]
    [no] >>>
    ```
    * 输入 `yes` 表示同意。（就类似安装软件时，选择我同意此协议才能继续安装。）
    * 下面要选择你做要安装的路径：
    ```bash
    Anaconda3 will now be installed into this location:
    /home/pancongwen/anaconda3

    - Press ENTER to confirm the location
    - Press CTRL-C to abort the installation
    - Or specify a different location below

    [/home/USER/anaconda3] >>>
    ```
    此处会默认安装在 `home` 目录当前用户的文件夹下，无特殊需求直接 `Enter` 即可。**记住这个路径，之后还会提到**。

4. 下面就会正式进入安装环节，你可以看到他安装的各种 `package`。
    ```bash
    installing: python-3.6.5-hc3d631a_2 ...
    Python 3.6.5 :: Anaconda, Inc.
    installing: blas-1.0-mkl ...
    installing: ca-certificates-2018.03.07-0 ...
    installing: conda-env-2.6.0-h36134e3_1 ...
    installing: intel-openmp-2018.0.0-8 ...
    installing: libgcc-ng-7.2.0-hdf63c60_3 ...
    installing: libgfortran-ng-7.2.0-hdf63c60_3 ...
    installing: libstdcxx-ng-7.2.0-hdf63c60_3 ...
    installing: bzip2-1.0.6-h14c3975_5 ...
    installing: expat-2.2.5-he0dffb1_0 ...
    installing: gmp-6.1.2-h6c8ec71_1 ...
    installing: graphite2-1.3.11-h16798f4_2 ...
    installing: icu-58.2-h9c2bf20_1 ...
    ...
    ```

5. 下面将 `Anaconda` 的路径加入 `.bashrc`。
    ```bash
    Do you wish the installer to prepend the Anaconda3 install location
    to PATH in your /home/pancongwen/.bashrc ? [yes|no]
    [no] >>>
    ```
    输入 `yes`，这个同意后，才能在环境下使用其安装的 `package`。
    官方 `FAQ` [链接](https://docs.anaconda.com/anaconda/faq/#distribution-faq-linux-path)：
    ```txt
    When installing Anaconda, we recommend that you do add Anaconda to the PATH if you answer “No” during installation to the question “Do you wish the installer to prepend the Anaconda<2 or 3>install location to PATH in your /home/<user>/.bashrc?”. Conda will not work until you add the PATH manually.

    To add the PATH manually, open a text editor and open the file .bashrc or .bash_profile from your home directory. Add the line export PATH="/<path to anaconda>/bin:$PATH".

    NOTE: Replace <path-to-anaconda> with the actual path of your installed anaconda file.

    Save the file. If you have any terminal windows open, close them all then open a new one. You may need to restart your computer for the PATH change to take effect.
    ```

6. 下面会推荐你安装 `Microsoft VSCode`（微软开发的一款开源IDE），看个人情况。
7. 安装完成。

ps: 更多信息请查看[官方安装文档](https://docs.anaconda.com/anaconda/install/linux/)。

### 验证
经过上面的安装，我们来验证一下安装是否成功。

0. 在刚刚安装时的 `Terminal` 输入以下命令：
    ```bash
    $ conda -V
    ```
    会得到 `conda: command not found` 的提示。这是因为添加到 `.bashrc` 中的设置不是即时生效的，会在之后打开的 `Terminal` 中生效。
    
1. 我们打开另一个 `Terminal` （快捷键 `Ctrl+Alt+t`），输入相同的命令：
    ```bash
    $ conda -V
    conda 4.5.4
    ```
    确认安装成功。

2. 你也可以查看 `conda` 命令的帮助：
    ```bash
    $ conda -h
    $ conda --help
    ```

## 如何使用 `conda` 来管理环境？

### 举例场景
举一个场景的例子帮助大家理解管理的步骤：  
- 一个叫做 `utc_time` 的 `Python` 项目
- 需要指定 `Python` 的版本为 `2.7`
- 需要安装对应版本的 `arrow` 库

### 准备工作
查看一些参数与之后做对比
- 当前 `Python` 版本：
    ```bash
    $ python -V
    ```
    如果之前电脑上没有 `python`，那么在安装过 `Anaconda` 后，会自动帮你安装其对应的版本。比如本文选择的是 `3.6.5`，那么输出即为 `3.6.5`。

- 当前 `python` 命令的路径：
    ```bash
    /home/pancongwen/anaconda3/bin/python
    ```
    可以看出现在 `python` 命令的可执行文件在 `/home/pancongwen/anaconda3/bin/python` 里面。

    > 补充知识 ： 关于 `ubuntu` 命令是如何全局使用的
    > 
    > `ubuntu` 里面的命令的可执行文件都是放在了全局变量 `PATH` 的路径里面：
    > ```bash
    > $ echo $PATH
    > ```
    > 或者
    > ```bash
    > $ $PATH
    > ```
    > 输出类似这样：
    > ```
    > bash: /home/pancongwen/anaconda3/bin:/home/pancongwen/bin:/home/pancongwen/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
    > ```
    > 每个路径以 `:`隔开。其中 `/home/pancongwen/anaconda3/bin` 就是我们刚刚下载安装的 `Anaconda` 的路径。

- 查看 `python` 库 `arrow` 是否存在。
    ```bash
    $ pip list
    ```
    查看有没有 `arrow` 这个 `package`。

### 创建一个项目

1. 新建文件夹 `utc_time`
    ```bash
    $ mkdir utc_time
    ```

2. 新建 `python` 脚本
    选择一款编辑器新建一个 `utc_time.py` 的文件，此处以 `vim` 为例。
    ```bash
    $ vim utc_time.py 
    ```
    将下方代码拷贝到 `utc_time.py` 中。
    ```python2.7
    #!/bin/usr/env python2.7

    import arrow

    utc = arrow.utcnow()

    print utc
    ```
    此脚本的作用就是输出当时的 `UTC` 时间。

3. 执行一下脚本
    ```bash
    $ python -m utc_time
    ```
    因为当前系统 `python` 版本为 `3.6.5`，则报错：
    ```bash
    SyntaxError: Missing parentheses in call to 'print'. Did you mean print(utc)?
    ```
    > 补充知识： `python2` 和 `python3` 关于 `print` 使用上的差别  
    > `python2` 打印对象：
    > ```python2
    > a = "hello"
    > print a 
    > ```
    > `python3` 打印对象：
    > ```python3
    > a = "hello"
    > print(a)
    > ```

### 使用 `conda` 管理环境
1. 新建环境 `py27`
    ```bash
    $ conda create --name py27 python=2.7
    ```
    创建一个 `conda` 环境，取名叫 `py27`，指定其语言为 `python` 且版本为 `2.7`。  
    输出见下方：
    ```bash
    Solving environment: done

    ## Package Plan ##

      environment location: /home/pancongwen/anaconda3/envs/py27

      added / updated specs: 
        - python=2.7


    The following packages will be downloaded:

        package                    |            build
        ---------------------------|-----------------
        libstdcxx-ng-8.2.0         |       hdf63c60_1         2.9 MB
        python-2.7.15              |       h1571d57_0        12.1 MB
        openssl-1.0.2p             |       h14c3975_0         3.5 MB
        readline-7.0               |       h7b6447c_5         392 KB
        certifi-2018.8.24          |           py27_1         139 KB
        setuptools-40.2.0          |           py27_0         585 KB
        tk-8.6.8                   |       hbc83047_0         3.1 MB
        wheel-0.31.1               |           py27_0          62 KB
        pip-10.0.1                 |           py27_0         1.7 MB
        sqlite-3.24.0              |       h84994c4_0         1.8 MB
        libgcc-ng-8.2.0            |       hdf63c60_1         7.6 MB
        ------------------------------------------------------------
                                               Total:        33.8 MB

    The following NEW packages will be INSTALLED:

        ca-certificates: 2018.03.07-0           
        certifi:         2018.8.24-py27_1       
        libedit:         3.1.20170329-h6b74fdf_2
        libffi:          3.2.1-hd88cf55_4       
        libgcc-ng:       8.2.0-hdf63c60_1       
        libstdcxx-ng:    8.2.0-hdf63c60_1       
        ncurses:         6.1-hf484d3e_0         
        openssl:         1.0.2p-h14c3975_0      
        pip:             10.0.1-py27_0          
        python:          2.7.15-h1571d57_0      
        readline:        7.0-h7b6447c_5         
        setuptools:      40.2.0-py27_0          
        sqlite:          3.24.0-h84994c4_0      
        tk:              8.6.8-hbc83047_0       
        wheel:           0.31.1-py27_0          
        zlib:            1.2.11-ha838bed_2 

    Proceed ([y]/n)? 
    ```
    确认后输入 `y`：
    ```bash
    Downloading and Extracting Packages
    libstdcxx-ng-8.2.0   | 2.9 MB    |  #############| 100% 
    python-2.7.15        | 12.1 MB   |  #############| 100% 
    openssl-1.0.2p       | 3.5 MB    |  #############| 100% 
    readline-7.0         | 392 KB    |  #############| 100% 
    certifi-2018.8.24    | 139 KB    |  #############| 100% 
    setuptools-40.2.0    | 585 KB    |  #############| 100% 
    tk-8.6.8             | 3.1 MB    |  #############| 100% 
    wheel-0.31.1         | 62 KB     |  #############| 100% 
    pip-10.0.1           | 1.7 MB    |  #############| 100% 
    sqlite-3.24.0        | 1.8 MB    |  #############| 100% 
    libgcc-ng-8.2.0      | 7.6 MB    |  #############| 100% 
    Preparing transaction: done
    Verifying transaction: done
    Executing transaction: done
    #
    # To activate this environment, use:
    # > source activate py27
    #
    # To deactivate an active environment, use:
    # > source deactivate
    #
    ```

2. 使用环境 `py27`
    ```bash
    $ source activate py27
    (py27) $ 
    ```
    激活 `py27` 环境之后，你可以在 `$` 前看到环境名称。

3. 确认当前 `python` 版本
    ```bash
    $ python --version
    Python 2.7.15 :: Anaconda, Inc.
    ```

4. 再次执行脚本
    ```bash
    $ python -m utc_time
    ```
    由于没有第三方库 `arrow`，会出现 `ImportError`：
    ```bash
    ImportError: No module named arrow
    ```

5. 在环境 `py27` 里面安装其他包  
    ```bash
    $ conda install arrow
    ```
    此处我们以 `python` 第三方库 `arrow` 的安装为例。
    ```bash
    Solving environment: done

    ## Package Plan ##

      environment location: /home/pancongwen/anaconda3/envs/py27

      added / updated specs: 
        - arrow


    The following packages will be downloaded:

        package                    |            build
        ---------------------------|-----------------
        arrow-0.12.1               |           py27_1          72 KB
        backports-1.0              |           py27_1           3 KB
        backports.functools_lru_cache-1.5|           py27_1           9 KB
        six-1.11.0                 |           py27_1          21 KB
        python-dateutil-2.7.3      |           py27_0         258 KB
        ------------------------------------------------------------
                                               Total:         364 KB

    The following NEW packages will be INSTALLED:

        arrow:                         0.12.1-py27_1
        backports:                     1.0-py27_1   
        backports.functools_lru_cache: 1.5-py27_1   
        python-dateutil:               2.7.3-py27_0 
        six:                           1.11.0-py27_1

    Proceed ([y]/n)? y


    Downloading and Extracting Packages
    arrow-0.12.1         | 72 KB     |  ############# | 100% 
    backports-1.0        | 3 KB      |  ############# | 100% 
    backports.functools_ | 9 KB      |  ############# | 100% 
    six-1.11.0           | 21 KB     |  ############# | 100% 
    python-dateutil-2.7. | 258 KB    |  ############# | 100% 
    Preparing transaction: done
    Verifying transaction: done
    Executing transaction: done
    ```

6. 再次执行脚本
    ```bash
    $ python -m utc_time
    2018-09-24T11:39:56.710756+00:00
    ```
    成功！

7. 退出环境
    ```bash
    $ source deactivate
    ```