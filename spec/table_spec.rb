require 'spec_helper'

RSpec.describe Table do
  describe 'columns access' do
    subject(:table) { my_table.new(data) }

    let(:data) do
<<TEXT
[
  {
    "name": "Alex Ivanov",
    "age": 27,
    "group": "admin"
  },
  {
    "name": "Peter Scherbakov",
    "age": 32,
    "group": "accounting",
    "permissions": [1,2,3]
  }
]
TEXT
    end
    let(:my_table) do
      Class.new(described_class) do
        column :name, type: String
        column :age, type: Integer
        column :group, type: String
        column :permissions, type: Array
      end
    end

    it 'returns correct attributes' do
      expect(table[0]).to have_attributes(name: 'Alex Ivanov',
                                          age: 27,
                                          group: 'admin')
    end

    it 'raises an error on getting unexisted field' do
      expect { table[0].permissions }.to raise_error NoMethodError
    end

    context 'when uncastable type' do
      let(:my_table) do
        Class.new(described_class) do
          column :name, type: Class.new
        end
      end

      it 'raises an error' do
        expect { table }.to raise_error TypeError
      end
    end

    context 'when passed undescribed column' do
      let(:my_table) do
        Class.new(described_class) do
          column :counter, type: Integer
        end
      end

      it 'raises an error' do
        expect { table }.to raise_error KeyError
      end
    end

    context 'when invalid column name' do
      let(:my_table) do
        Class.new(described_class) do
          column :'$!:#!@#!@', type: Integer
        end
      end
      let(:data) do
        [
          {
            "$!:#!@#!@": 27,
          }
        ].to_json
      end

      it 'raises an error' do
        expect { table }.to raise_error NameError
      end
    end
  end
end
