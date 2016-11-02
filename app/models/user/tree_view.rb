class User::TreeView
  def initialize(stacks:, documents:)
    @stacks = stacks
    @documents = documents
  end

  def arrange
    {}.tap do |hash|
      @stacks.each do |stack|
        hash[stack] = stack.documents.to_a
      end

      @documents.each do |document|
        next if @stacks.include?(document.stack)
        hash[document] = nil
      end
    end
  end
end
