# ArtWorkDraft
[![Build Status](https://travis-ci.org/AnthonySuper/artworkdraft.svg?branch=master)](https://travis-ci.org/AnthonySuper/artworkdraft)

It's an art website!


## Contributing

We welcome code contributions.
We also welcome [issues](https://github.com/AnthonySuper/artworkdraft/issues).
Feel free to make a feature request, a bug report, or anything else.

## Setting Up

This is a bog-standard rails environment.
Essentially, you need to install:


1. Ruby 2.5.3 (RVM is one way to do this)
2. PotsgreSQL
3. Bundler
4. Node.js
5. Yarn

That's it!


### Prepare the Environment

Your database needs to allow local connections.
From there, run the following commands

```bash
bundle
yarn
rails db:setup
rails s
```

You now have a working development environment.

## Deploying

This repo uses continuous deployment.
The `master` branch lives *on production* at all times.
As a result, all development *must* be done on the `development` branch!

Branches will not be merged to master until they are in some way "complete."
Ideally, this includes extensive tests of any new functionality.
Keep this in mind when contributing.

