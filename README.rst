eversite
========
Build and maintain your website right inside your evernote.

|

live demo
---------
| My blog: http://www.tylerlong.me
| Actually eversite is not limited to building blogs. It's a general purpose CMS system.

|

features
--------
- does NOT require database.
- manage EVERY thing in your evernote client: create pages, modify pages, delete pages...etc.
- HTML5 + bootstrap for UI, clean and clear.
- support atom feed automatically.

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
edit `config/application.yml`_, change the following settings:

.. _`config/application.yml`: https://github.com/tylerlong/eversite/blob/master/config/application.yml

- site_name: the name of your website
- time_zone: your local time zone
- page_size: maximun entries for a page
- evernote username
- evernote password
- evernote consumer_key
- evernote consumer_secret
- disqus shortname
- google analytics tracking id
- header_links: links shown on the header
- footer_links: links shown on the footer

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
- tags for each blog entry
- use separate request for image showing
- highlight the content of embeded code files
- searching functionality
- add integration tests
- submit to oschina.net