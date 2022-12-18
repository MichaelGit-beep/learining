1. Check all branches containing specific committ. `-a to show remote and local`
```
git branch --contains ae95b0d48de8241ffc5c84a6bdbcacaf4471211f -a
```

2. Delete branch. `If you want to delete default branch on github, first, need to change it to some other branch`
```
git branch --delete <branchname>
git push origin --delete <branchname>
```

3. Show history
```
git log --graph --date=short  --pretty=format:"%C(yellow)%h%C(reset) %ad | %C(75)%s%C(reset) %C(yellow)%d%C(reset) [%an]"
```