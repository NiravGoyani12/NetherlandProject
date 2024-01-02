# How to fix submodule

In our project, we using our own cucumber-js which is same as Cucumber 7.0 version, but add one new feature, that to support pass parallel process number to cucumber messages. Cucumber-JS is a slow updated open source community, we need to main it by ourselves. 

### Issue:
When we accidently add packages/cucumber-js to .gitignore, it will break all eco-system, not only local copy, but also in Jenkins.

```
# Remove modules
git submodule deinit -f -- packages/cucumber-js
rm -rf .git/modules/packages/cucumber-js
git rm -f packages/cucumber-js

# Add modules back
cd packages
git submodule add https://884445-rsiad3v-b2ceu-bd1repo01.pvh.com/pvh-qa/cucumber-js.git

# Rebuild project dependency
npm ci

# Push to remote
git add .
git commit -m 'Fix sub module'
git push
```

