# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DocumentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "document"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update(data)
    ActionCable.server.broadcast 'document', body: data["body"]
  end
end
