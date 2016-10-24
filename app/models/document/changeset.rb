class Document::Changeset
  delegate :versions, :collaborators, to: :document

  attr_accessor :document

  def since_last_seen(user)
    return unless last_seen = user.last_seen_at
    return unless versions = versions_since(last_seen)

    versions.reduce([]) do |collection, version|
      next if version.whodunnit.to_i == user.id
      collection << Document::Changeset::Diff.new(version)
    end
  end

  def versions_since(date)
    query = versions.where(created_at: date..Time.current)
    query if query.present?
  end
end
