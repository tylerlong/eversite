eversite
========
build and maintain your website right inside your evernote.

|

live demo
---------
http://tylerlong.herokuapp.com

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
- footer_links: links show on the footer

|

todo list
---------
- atom feed for note books
- tags cloud
- pagination
- image showing
- use hashie to simplify hash accessing ?
- show created and updated timestamp in show page