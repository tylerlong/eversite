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

1. git clone git://github.com/tylerlong/eversite.git && cd eversite
#. bundle install --binstubs ./bundler_stubs && cd .. && cd -
#. modify file config/application.yml
#. rails s
#. open your browser, navigate to http://localhost:3000

|

configuration
-------------
edit config/application.yml, change the following settings:

- site_name: the name of your website
- time_zone: your local time zone
- page_size: maximun entries for a page
- evernote username
- evernote password
- evernote consumer_key
- evernote consumer_secret
- disqus shortname
- google analytics tracking id
- header_links: links show on the header
- footer_links: links show on the footer

|

how to find the guid of a note
------------------------------
1. In you evernote desktop client, select the note.
#. Right click, select "Copy Note link".
#. Past the link to notepad, and you will see the guid.

|

todo list
---------
- atom feed for note books (add rss icon to header links)
- tags cloud
- use hashie to simplify hash accessing ?
- thumbnail instead of snippet? (evernote has a thumbnail api)
- use separate request for image showing
- highlight the content of embeded code files
- searching functionality
- add integration tests
- submit to oschina.net