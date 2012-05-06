eversite
========
build and maintain your website right inside your evernote.

|

live demo
---------
My blog: http://www.tylerlong.me
Actually eversite is not limited to building blogs. It's a general purpose CMS system.

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
- tags cloud
- thumbnail instead of snippet? (evernote has a thumbnail api)
- use separate request for image showing
- highlight the content of embeded code files
- searching functionality
- add integration tests
- submit to oschina.net
- default https ?
- refactor evernote authentication code, cache result for 30 minutes.