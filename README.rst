eversite
========
build and maintain your website right inside your evernote.

|

quick start
-----------
git clone git://github.com/tylerlong/eversite.git && cd eversite
bundle install --binstubs ./bundler_stubs
modify file config/application.yml
rails s

|

configuration
-------------
edit config/application.yml, change the following settings:

- site_name: the name of you website
- username: username of your evernote account
- password: password of your evernote account
- links: links show on the header

|

todo list
---------
- atom feed for note books
- add links at footer
- switch themes
- cache pages
- tags cloud
- pagination
- blog entry snippet