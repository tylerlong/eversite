require 'evernote'
require 'date'
require 'nokogiri'

class EvernotesController < ApplicationController

  def common
    link = CONFIG['header_links'].select do |link|
      add_trailing_slash(link['path']) == first_token(request.path)
    end.first || not_found
    resource = link['resource']
    case resource['type']
      when 'notebook'
        @title = link['text']
        handle_notebooks(resource['name'])
      when 'note'
        handle_note(resource['guid'])
      else
        not_found
    end
  end

  def show
    created = DateTime.strptime(params[:created], '%s').strftime('%Y%m%dT%H%M%SZ')
    @note = get_note_by_created(created, true) || not_found
  end


  private

    def first_token(path)
      token = path.split('/').select{ |token| !token.blank? }.first
      return '/'  if token.nil? || token.include?('.')
      return "/#{token}/"
    end

    def handle_notebooks(name)
      @page = (params[:page] || '1').to_i
      @notes = get_notes_list(name, @page) || not_found
      if @notes.size > CONFIG['page_size']
        @has_next = true
        @notes = @notes[0...@notes.size - 1]
      end
      respond_to do |format|
        format.html { render 'index' }
        format.atom { render 'index'}
      end
    end
    def handle_note(guid)
      @note = get_note_by_guid(guid, true) || not_found
      render 'show'
    end

    @@note_store = @@auth_token = @@shard_id = nil
    def authenticate
      user_store_url = "https://#{CONFIG['evernote']['domain']}/edam/user"
      user_store = Evernote::UserStore.new(user_store_url, CONFIG['evernote']['config'])
      authentication = user_store.authenticate
      @@shard_id, @@auth_token = authentication.user.shardId, authentication.authenticationToken
      note_store_url = "http://#{CONFIG['evernote']['domain']}/edam/note/#{@@shard_id}"
      @@note_store = Evernote::NoteStore.new(note_store_url)
    end
    def note_store
      @@note_store || authenticate || @@note_store
    end
    def auth_token
      @@auth_token || authenticate || @@auth_token
    end
    def shard_id
      @@shard_id || authenticate || @@shard_id
    end

    CONTENT_REGEXP = /<en-note[^>]*?>(.+?)<\/en-note>/m
    def extract_content(content)
      CONTENT_REGEXP =~ content
      $1.force_encoding('utf-8')
    end

    def extract_snippet(content)
      Nokogiri::HTML(content).text[0..192]
    end

    IMAGE_REGEXP_STR = '<en-media hash="#md5#" .*? type="image/png".*?/>'
    def embed_images(note)
      return note if note[:resources].nil?
      note[:resources].each do |resource|
        next if resource.data.body.nil? || !resource.mime.start_with?('image/')
        image_regex = Regexp.new(IMAGE_REGEXP_STR.sub('#md5#', resource.data.bodyHash.unpack('H*')[0]))
        note[:content] = note[:content].sub(image_regex, "<img src='data:image/png;base64,#{Base64.encode64(resource.data.body)}'/>")
      end
      note
    end

    def get_notes_list(notebook_name, page)
      notebook = note_store.listNotebooks(auth_token).select { |notebook| notebook.name.force_encoding('utf-8') == notebook_name }.first || not_found
      note_filter = Evernote::EDAM::NoteStore::NoteFilter.new(notebookGuid: notebook.guid,
        order: Evernote::EDAM::Type::NoteSortOrder::CREATED, ascending: false)
      notes = note_store.findNotes(auth_token, note_filter, (page - 1) * CONFIG['page_size'], CONFIG['page_size'] + 1).notes
      notes.map { |note| Hashie::Mash.new { title: note.title.force_encoding('utf-8'), created: note.created, snippet: extract_snippet(get_note_by_guid(note.guid, false)[:content]) } }
    end

    def get_note_by_guid(guid, with_resource_data = false)
      note = note_store.getNote(auth_token, guid, true, with_resource_data, false, false) || not_found
      note = { title: note.title.force_encoding('utf-8'), content: extract_content(note.content),
        created: note.created, updated: note.updated, resources: note.resources }
      embed_images(note)
    end

    def get_note_by_created(created, with_resource_data = false)
      note_filter = Evernote::EDAM::NoteStore::NoteFilter.new(words: "created:#{created}",
        order: Evernote::EDAM::Type::NoteSortOrder::CREATED, ascending: true)
      note = note_store.findNotes(auth_token, note_filter, 0, 1).notes.first || not_found
      get_note_by_guid(note.guid, with_resource_data)
    end
end