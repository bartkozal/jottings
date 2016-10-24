# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DocumentChannel < ApplicationCable::Channel
  def subscribed
    @document = current_user.documents.find(MaskedId.decode(params[:id]))
    stream_for @document
  end

  def unsubscribed
    current_user.touch(:last_seen_at)
  end

  def update(data)
    self.class.broadcast_to @document, body: data["body"]
  end
end
