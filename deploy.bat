set -e 
npm run build

cd dist

git init
git add -A
git commit -m "Why ae"

git push -f @git@github.com:bekov001/cyrpto_currency.git master:gh-pages

cd -