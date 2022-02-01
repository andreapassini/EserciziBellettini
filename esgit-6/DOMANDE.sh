git init

# Commit uno
printf "primo file" >> primo
git add primo
git commit -m "uno"

# Branch develop
git branch develop
git switch develop

# Commit "sviluppi"
printf "\nmodificato" >> primo
git add primo
git commit -m "sviluppi"

# Primo dangling
# Commit "ok ma da spostare"
printf "terzo file" >> terzo
git add terzo
git commit -m "ok ma da spostare"

git switch master

# Commit due
printf "secondo file" >> secondo
git add secondo
git commit -m "due"

# Rebase
git switch develop
git rebase master

# Commit "tre"
git commit --amend -m "tre"