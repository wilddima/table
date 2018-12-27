class Row
  attr_reader :cells, :types

  def initialize(cells, types:)
    @cells = cast_types!(cells, types).each do |key, val|
      instance_variable_set(:"@#{key}", val)
      singleton_class.attr_accessor(key)
    end
  end

  private

  def cast_types!(cells, types)
    cells.each_with_object({}) do |(key, val), acc|
      acc[key] = method(types.fetch(key).to_s).call(val)
    end
  end
end
