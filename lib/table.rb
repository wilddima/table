require 'json'
require 'forwardable'
require_relative 'row'

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
    @data = JSON.parse(raw_data, symbolize_names: true)
                .map { |row| Row.new(row, types: self.class.columns) }
  end
end
