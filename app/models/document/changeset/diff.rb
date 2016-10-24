class Document::Changeset::Diff
  def initialize(version)
    @version = version
  end

  def author
    @version.item.collaborators.find_by(id: @version.whodunnit) || "Unknown"
  end
end
