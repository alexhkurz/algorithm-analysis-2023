# On the Use of Git

[Git](https://en.wikipedia.org/wiki/Git) is a version control software created by Linus Torvalds (also responsible for giving us Linux). There are different commercial implementations of git. Even though, as some say, the [time has come to give up GitHub](https://sfconservancy.org/blog/2022/jun/30/give-up-github-launch/), the following notes still refer to [Github](https://github.com/). There is also a [lawsuit against Github](https://githubcopilotinvestigation.com/) which is motivated by Github building its success on becoming the repository of open source software development and then, as some claim, abusing the trust that open source developers brought to the platform. I had no time to look into [Resources to Give Up GitHub](https://sfconservancy.org/GiveUpGitHub/) myself yet, but if you want to try alternatives have a go.

## New to Git?

Have a look at this [tutorial](https://guides.github.com/activities/hello-world/). Let me know if there are problems or if you have other helpful sources.

Watch the video of the MIT Missing Lecture Series on [Version Control (Git)](https://missing.csail.mit.edu/2020/version-control/). (Btw, all of the series is highly recommended.)

## Git best practices

I collect here some lessons learned from using git for assignments in various courses. 

Proper use of git will be considered for grading. Depending on the nature of the assignment, complete solutions uploaded to the repo just before the deadline and not containing a trail of your work **may not be accepted for grading**.

- Use the repo to create a trail of your work. Commit and push often.  
- Be careful about what you commit:  
   - Do not track/commit/push machine generated files. 
   - Avoid unthinking use of `git add *`. Only add files that should be tracked. 
   - Run `git status`. If you see under `Untracked files` names that you don't recognize, they are likely machine generated files. Do not track those. Rather add these names to a file named `.gitignore` at the root of your repo.
   - Build up your `.gitignore` incrementally using `git status` and add files you do not want to track to `.gitignore` step by step. You can start from my .gitignore file in this repo.
   - Meaningful commit messages will help yourself and collaborators.
- Do not create different versions of files by copying them. [Use branches](http://shafiul.github.io/gitbook/3_basic_branching_and_merging.html) for collaborative projects in which you and your collaborators want to work simultaneously but independently on the same project. Branches can be merged later.
- Delete files only in exceptional circumstances. (Btw, even deleted files will remain accessible via the history.)

## Further reading

The links below are written for more complex projects than a typical assignment, but it cannot harm to have a look:

- [The Git Community Book](http://shafiul.github.io/gitbook/index.html)
- [Commit Often, Perfect Later, Publish Once: Git Best Practices](https://sethrobertson.github.io/GitBestPractices/)
- [Examples of gitignore files](https://github.com/github/gitignore)
-  Some pages from 
    - [github.com](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository)
      - [creating](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-new-repository)
      - [cloning](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository)
    - [git-scm.com](https://git-scm.com/):
      - [Getting a Git Repository (clone)](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)
      - [Working with Remotes](https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)
      - [Contributing to a Project (fork)](https://git-scm.com/book/en/v2/GitHub-Contributing-to-a-Project) (probably not relevant for us)
- Further information:
  - [How do I update a GitHub forked repository?](https://stackoverflow.com/questions/7244321/how-do-i-update-a-github-forked-repository)

## Some commands

- [To throw away all uncommitted local changes:](http://shafiul.github.io/gitbook/4_undoing_in_git_-_reset,_checkout_and_revert.html)
  ``` 
  git fetch origin
  git reset --hard origin
  ```