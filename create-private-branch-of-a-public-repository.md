# Create private branch of a public repository

From https://gist.github.com/mfbenitezp/5a49086a6c8333fc3b82e56b7892f7ee
This gist describes how to create private branch (**downstream**) of a public repository (**upstream**).

## Create the private-repo on github

## Initialize repository

```shell
$ git init private-repo
$ cd private-repo
```

## Add remotes

```shell
$ git remote add upstream https://github.com/<username>/public-repo.git
$ git remote add origin https://github.com/<username>/private-repo.git
$ git remote --verbose
```

## Initial commit

```shell
$ git commit --allow-empty --message "Initial commit"
$ git push --set-upstream origin main
```

## Create development branch

```shell
$ git checkout -b develop
$ git push --set-upstream origin develop
$ git branch --all
```

## Merge upstream into development branch

```shell
$ git fetch upstream main
$ git merge --allow-unrelated-histories upstream/main
$ git push
```

## Some changes on repository...

```shell
# Do some changes...
$ git add .
$ git commit -m "Some changes"
$ git push
```

## Apply upstream changes...

```shell
$ git fetch upstream main
$ git log --all --graph --oneline
$ git merge upstream/main
$ git push
```

## Merge development branch to main

```shell
$ git switch main
$ git merge develop
$ git push
$ git log --all --graph --oneline
```

----------

For next clones:

## Clone repository

```shell
$ git clone https://github.com/<username>/private-repo.git
$ cd private-repo
```

## Add upstream remote

```shell
$ git remote add upstream https://github.com/<username>/public-repo.git
$ git remote --verbose
```

## Switch to development branch and get upstream changes

```shell
$ git switch develop
$ git fetch upstream main
$ git log --all --graph --oneline
$ git merge upstream/main
```
