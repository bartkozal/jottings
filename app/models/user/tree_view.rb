class User::TreeView
  def initialize(stacks:, documents:)
    @stacks = stacks
    @documents = documents
  end

  def documents
    [].tap do |array|
      @documents.each do |document|
        next if @stacks.include?(document.stack)
        array << document
      end
    end
  end

  def stacks
    {}.tap do |hash|
      @stacks.each do |stack|
        hash[stack] = stack.documents.to_a
      end
    end
  end

  def arrange
    {}.tap do |hash|
      hash.merge!(stacks)
      documents.each do |document|
        hash[document] = nil
      end
    end
  end
end
