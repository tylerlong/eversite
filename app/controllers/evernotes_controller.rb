class EvernotesController < ApplicationController
  def index
    require 'evernote'

    user_store_url = "https://sandbox.evernote.com/edam/user"

    config = {
       :username => 'tylerlong',
       :password => 'fihu2zim',
       :consumer_key => 'tylerlong',
       :consumer_secret => 'c9a682d60f9a442c'
    }

    user_store = Evernote::UserStore.new(user_store_url, config)

    auth_result = user_store.authenticate
    auth_token = auth_result.authenticationToken
    user = auth_result.user

    note_store_url = "http://sandbox.evernote.com/edam/note/#{user.shardId}"
    note_store = Evernote::NoteStore.new(note_store_url)

    notebook = note_store.listNotebooks(auth_token).select do |notebook|
      notebook.name.downcase == "blog"
    end[0]

    @notes = note_store.findNotes(auth_token, Evernote::EDAM::NoteStore::NoteFilter.new(notebookGuid: notebook.guid), 0, 1000).notes

    @note = note_store.getNote(auth_token, @notes[1].guid, true, true, true, true)
  end

  def show
  end
end