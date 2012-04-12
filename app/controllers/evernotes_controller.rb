require 'evernote'

class EvernotesController < ApplicationController
  def index
    @notes = get_notes_list
  end

  def show
    @note = get_note(params[:guid])
  end

  private

    def authenticate
      user_store_url = "https://sandbox.evernote.com/edam/user"
      config = {
         :username => 'tylerlong',
         :password => 'fihu2zim',
         :consumer_key => 'tylerlong',
         :consumer_secret => 'c9a682d60f9a442c'
      }
      user_store = Evernote::UserStore.new(user_store_url, config)
      authentication = user_store.authenticate
      user, auth_token = authentication.user, authentication.authenticationToken
      note_store_url = "http://sandbox.evernote.com/edam/note/#{user.shardId}"
      note_store = Evernote::NoteStore.new(note_store_url)
      return note_store, auth_token
    end

    def get_notes_list
      note_store, auth_token = authenticate
      notebook = note_store.listNotebooks(auth_token).select do |notebook|
        notebook.name.downcase == "blog"
      end[0]
      note_store.findNotes(auth_token, Evernote::EDAM::NoteStore::NoteFilter.new(notebookGuid: notebook.guid), 0, 1000).notes
    end

    def get_note(guid)
      note_store, auth_token = authenticate
      note_store.getNote(auth_token, guid, true, true, true, true)
    end
end