#!/bin/zsh
lang=$1
if [[ $lang = "python" ]]; then
    echo "Python pre-commit not yet implemented."
    # if python project
    # pip install pre-commit
    # install pre-commit commit-msg-hook
    # pre-commit install --hook-type commit-msg
else
    echo "Run default node hook install"
    # Install and configure if needed
    npm install --save-dev @commitlint/{cli,config-conventional}
    # Install Husky v5
    npm install husky --save-dev
    # Active hooks
    npx husky install
    # Add hook
    npx husky add .husky/commit-msg "npx --no-install commitlint --edit --config .commitlint.config.js $1"
fi

FILE=.commitlint.config.js
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "Creating .commitlint.config.js"
    echo "module.exports={extends:['@commitlint/config-conventional'],parserPreset:{parserOpts:{issuePrefixes:['[A-Z]{2,}-']}},rules:{'references-empty':[2,'never']}}" > .commitlint.config.js
fi

echo "Add commitlint files to gitignore."
echo -e "\n# commitlint\n.husky/\nnode_modules/" >> .gitignore
echo ".gitgnore updated"