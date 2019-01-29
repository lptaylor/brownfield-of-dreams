class Repository
  attr_reader :name, :html_url, :id
  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @html_url = attributes[:html_url]
  end
end
