# Init git repo
git init

# Commit "start"
printf "inizio" > A
printf "inizio2" > B
git add A B
git commit -m "start"

# Rename branch "master" into "main"
git branch -m master main

# Create branch "develop"
git branch develop

# Commit "grande fatica"
printf "\nmodifica talmente lunga che non ho voglia di riscrivere due volte" >> B
git add B
git commit -m "grande fatica"

# Checkout sul branch "develop"
git checkout develop

# Commit "tentativo"
mkdir Backup
cp A Backup/A
cp B Backup/B
printf "aggiunta" >> A
git add A Backup/A Backup/B
git commit -m "tentativo"

# Cherry pick
git cherry-pick main

# Commit "sporcizia?"
printf "non ricordo la modifica" > Foo
git add Foo
git commit -m "sporcizia?"

# Checkout sul branch "main"
git checkout main

# Amend. creo il commit dangling
git commit --amend -m "Evviva git"

# Changes in index
printf "\nfine?" >> B
git add B

# Changes in working directory
printf "... fine" >> B

# Changes in working directory (untracked)
printf "nuovo inizio" > O
