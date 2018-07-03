# README

This is a template app. Steps to get started:

    git clone git@github.com:jess/brown_template.git
    bundle install

Rename all references of `BrownTemplate` or `brown_template` to whatever
you want your app name to be.

To regenerate the credentials file, we need to keep Devise from
squawking we need to uncomment the 10th line in
`config/initializers/devise.rb` referencing `config.secret_key`

Then run:

    bin/rails credentials:edit

This will generate your master key file and encrypted credentials
file. You can add the comment back to the devise file.

Now run your normal `rake db:create db:migrate` and you're good to go.

Now you can pull in branches of the features you want.
