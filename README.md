# table

```ruby
class MyTable < Table
  column :name, type: String
  column :age, type: Integer
  column :permissions, type: Hash
end

json = <<~TEXT
[
  {
    "name": "Dmitrii",
    "age": "25",
    "permissions": {
      "read": "true",
      "write": "true"
    }
  }
]
TEXT

tab = MyTable.new(json)

tab[0].name #=> "Dmitrii"
tab[0].age #=> 25
tab[0].permissions #=> { read: 'true', write: 'true' }
```
