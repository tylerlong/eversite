require 'evernote'

class EvernotesController < ApplicationController

  def common
    link = CONFIG['links'].select { |link| link['path'] == request.path }.first
    resource = link['resource']
    case resource['type']
    when 'notebook'
      @notes = get_notes_list(resource['name'])
      return render 'index'
    when 'note'
      @note = get_note(resource['guid'])
      return render 'show'
    else
      raise ActiveRecord::NotFound
    end
  end

  def show
    @note = get_note(params[:guid])
  end

  private

    def authenticate
      user_store_url = "https://#{CONFIG['evernote_domain']}/edam/user"
      user_store = Evernote::UserStore.new(user_store_url, CONFIG['evernote_config'])
      authentication = user_store.authenticate
      user, auth_token = authentication.user, authentication.authenticationToken
      note_store_url = "http://#{CONFIG['evernote_domain']}/edam/note/#{user.shardId}"
      note_store = Evernote::NoteStore.new(note_store_url)
      return note_store, auth_token
    end

    def get_notes_list(notebook_name)
      note_store, auth_token = authenticate
      notebook = note_store.listNotebooks(auth_token).select { |notebook| notebook.name.force_encoding('utf-8') == notebook_name }.first
      note_store.findNotes(auth_token, Evernote::EDAM::NoteStore::NoteFilter.new(notebookGuid: notebook.guid), 0, 1000).notes
    end

    CONTENT_REGEXP = /<en-note[^>]*?>(.+?)<\/en-note>/m
    def get_note(guid)
      note_store, auth_token = authenticate
      note = note_store.getNote(auth_token, guid, true, true, true, true)
      CONTENT_REGEXP =~ note.content
      { title: note.title.force_encoding('utf-8'), content: $1.force_encoding('utf-8') }
    end
end