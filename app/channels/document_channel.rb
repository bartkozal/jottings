# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class DocumentChannel < ApplicationCable::Channel
  def subscribed
    decoded_id = MaskedId.decode(:document, params[:id])
    @document = current_user.documents.find(decoded_id)
    stream_for @document
    appear
  end

  def unsubscribed
    disappear
  end

  def appear
    @document.online_users.push(current_user.email)
    @document.save
    self.class.broadcast_to @document, online_users: @document.online_users
  end

  def disappear
    @document.online_users.delete(current_user.email)
    @document.save
    self.class.broadcast_to @document, online_users: @document.online_users
  end
end
