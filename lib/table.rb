require 'json'
require 'forwardable'
require 'row'

class Table
  extend Forwardable

  TYPES = [Integer, Float, String, Array, Hash].freeze

  attr_reader :data

  def_delegators :@data, :[], :size

  class <<  self
    attr_reader :columns

    def column(index, type:)
      raise TypeError, "Uknown type #{type}. Available types: #{TYPES.join(', ')}" unless TYPES.include? type
      @columns ||= {}
      @columns[index.to_sym] = type
      @columns
    end
  end

  def initialize(raw_data)
    @data = parse_data(raw_data).map { |row| Row.new(row, types: self.class.columns) }
  end

  private

  def parse_data(raw_data)
    return raw_data if raw_data.is_a? Array
    return JSON.parse(raw_data, symbolize_names: true) if raw_data.is_a? String
    raise TypeError, "Can't parse data: '#{raw_data}'. It should be an array or json."
  end
end
