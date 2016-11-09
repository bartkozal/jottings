# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DocumentChannel < ApplicationCable::Channel
  def subscribed
    decoded_id = MaskedId.decode(:document, params[:id])
    @document = current_user.find_document(decoded_id)
    stream_for @document
  end

  def unsubscribed
    current_user.touch(:last_seen_at)
  end

  def update(data)
    self.class.broadcast_to @document, body: data["body"]
  end
end
