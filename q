[1mdiff --git a/Git study.docx b/Git study.docx[m
[1mindex 9daa213..7a12162 100644[m
[1m--- a/Git study.docx[m	
[1m+++ b/Git study.docx[m	
[36m@@ -122,4 +122,67 @@[m [m$ git status:[m
 * git checkout BranchName	查看BranchName[m
 * git branch -d BranchName	删除BranchName[m
 * git checkout CommitID	查看某个commitID[m
[31m-注意：[m
[32m+[m[32m注意：此时，可能会切换到"旧的"版本（detached HEAD），"目前不在最新版"的提示。由于此版本已有下一版，如果在目前的"旧版"执行git commit，会导致刚刚创建的版本，无法被追踪。正确的方法是：建立分支。[m
[32m+[m[32m7. 对比档案与版本差异[m
[32m+[m[32m7.1 git diff的基本观念[m
[32m+[m[32m* 先用git log得到版本资讯，并取得最近两个commit的id[m
[32m+[m[32m* 执行git diff commit1 commit2，对比两个版本差异。commit1用旧版，commit2用新版[m
[32m+[m[32m$ git diff d120304519439dd8bade2eb2dae81b2226a4e02b dc1d4e5bebd863a9a1f4d5f5a3b4fa5cdf53c3f2[m
[32m+[m
[32m+[m[32m* diff --git: 对哪两个档案进行比较[m
[32m+[m[32m* index ca90535..00b30ed 100644: git此次对比的标头资讯header line，后面两个hash id代表Git object storage中两个blob物件的id。100644是git属性，类似Linux的rwx[m
[32m+[m[32m* ---a/a.txt 两个比对版本中"旧的"那个版本[m
[32m+[m[32m* +++b/a.txt两个比对中"新的"那个[m
[32m+[m[32m* @@ -1 +1 @@旧版的总行数与新版的总行数[m
[32m+[m[32m* 变更的内容[m
[32m+[m[32m  + "-"开头，代表旧版到新版，此行被删除[m
[32m+[m[32m  + "+"开头，代表旧版到新版，此行新增[m
[32m+[m[32m  + 空白字元开头，代表新旧版本都出现，没有变更[m
[32m+[m[32m7.2 四种基本比较方式[m
[32m+[m[32m* git diff: 不加任何参数，对比"工作目录"和"索引"的差异[m
[32m+[m[32m* git diff commit: 对比"工作目录"与"指定commit物件里的那个tree物件"[m
[32m+[m[32m最常用：git diff HEAD，对比"工作目录"与"当前分支最新版"，这种方法，不会对比"索引"[m
[32m+[m[32m* git diff --cached commit: 对比"索引"与"指定commit物件里的那个tree物件"[m
[32m+[m[32m最常用：git diff --cached HEAD，对比"索引"与"当前分支最新版"[m
[32m+[m[32m* git diff commit1 commit2[m
[32m+[m[32m8. Git物件的绝对名称[m
[32m+[m[32m8.1 物件绝对名称[m
[32m+[m[32mGit中，每个物件有一个SHA杂凑运算的ID，这就是"绝对名称"。[m
[32m+[m[32m"简短语法"：不少于4个字元（4~40个长度都可用）[m
[32m+[m[32mgit log --pretty = oneline			一行显示结果[m
[32m+[m[32mgit log --pretty = oneline --abbrev-commit	一行，并且仅输出部分"绝对名称"[m
[32m+[m[32m9. Git物件的一般参照与符号参照[m
[32m+[m[32mGit版控最常用的"参照名称"[m
[32m+[m[32m9.1 物件的参照名称[m
[32m+[m[32m参照名称ref： Git物件的一个"指标"，相对绝对名称的另一个"好记名称"。[m
[32m+[m[32m"分支名称"，HEAD，或之后学的"标签名称"，都是"参照名称"[m
[32m+[m[32m$ git branch	得到分支名称。分支名称其实就是"参照名称"，代表这三个"参照名称"分别对应Git物件储存库中的三个commit物件。其实，分支的参照名称，实际就是一个档案而已（.git\ref\heads目录下）[m
[32m+[m[32m档案如何跟"绝对名称"连接？[m
[32m+[m[32m$ git branch		we are now in newbranch3[m
[32m+[m[32m$ git log --pretty = oneline[m
[32m+[m[32m打开.git\ref\heads\newbranch3，纯文字档，指向版本历史的"最新版"[m
[32m+[m[32m$ git cat-file  - p commitID	取得commit物件内容[m
[32m+[m[32m$ git show commitID		取得版本变更记录[m
[32m+[m[32m$ git cat-file newbranch3	$ git cat-file commitID		绝对名称和相对名称，执行得到相同结果[m
[32m+[m[32m9.2 关于.git\refs\目录[m
[32m+[m[32m所有"参照目录"实际是一个档案，包含文件的绝对名称，放在.git\refs下。输入git cat-files  - p BranchName，Git会寻找"参照名称文档"，取出内容（即Git物件的绝对名称）[m
[32m+[m[32m.git/refs/heads/[m
[32m+[m[32m.git/refs/remotes/[m
[32m+[m[32m.git/refs/tags/[m
[32m+[m[32m9.3 物件的符号参照名称(symref)[m
[32m+[m[32m符号参照名称(symref)也是参照名称(ref)的一种，只是内容不同。"符号参照"，指向另一个参照名称[m
[32m+[m[32m$ type .git\HEAD	# ref: refs/heads/newbranch1[m
[32m+[m[32m* HEAD[m
[32m+[m[32m  + 指向"工作目录"设定分支的最新版[m
[32m+[m[32m  + git commit后，HEAD也更新至最新版[m
[32m+[m[32m* ORIG_HEAD[m
[32m+[m[32m  + HEAD这个commit物件的"前一版"，常用来恢复上一版[m
[32m+[m[32m* FETCH_HEAD[m
[32m+[m[32m  + 远端储存库时，可能会使用git fetch取回所有远端储存库的物件。FETCH_HEAD符号参考，记录远端储存库每个分支的HEAD（最新版）的绝对名称[m
[32m+[m[32m* MERGE_HEAD[m
[32m+[m[32m  + 合并工作时，"合并来源"的commit物件绝对名称会被记录在MERGE_HEAD中[m
[32m+[m[32m9.4 一般参考与符号参考使用方式[m
[32m+[m[32mgit update-ref自由建立"一般参考"[m
[32m+[m[32m$ git update-ref NewRefName commitID[m
[32m+[m[32m注意：可以指向任意Git物件，不是一定要commit物件；较正式，最好加上refs/开头，如git update-ref refs/NewRefName [objectID][m
[32m+[m[32m10. 认识Git物件的相对名称[m
