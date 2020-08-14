# Quiz 1

## Describe `ActiveRecord` pattern at a high level

`ActiveRecord` uses rich objects to represent rows from a table. The objects have getter and setter methods on them as well, so making changes to the table's rows does not require writing raw SQL. The **model**, which is a wrapper for row(s) from a table, is used to interact with the rows of the table through objects.

The model can be used to create records (rows), update records, delete records, and view records. Models are also used to show the relationships (one-many, many-one, etc.) between different resources. 

For instance, if I have `Book` and `Author`, the models demonstrate their relationship through **associations**.

## If there's an ActiveRecord model called "CrazyMonkey", what should the table name be?

The table should be `crazy_monkeys`. The table name is the pluralized form of the model name.

## If I'm building a 1:M association between Project and Issue, what will the model associations and foreign key be?

A `project` has many `issues` and an `issue` belongs to a `project`.

```ruby
class Project < ApplicationRecord
  has_many :issues
end

class Issue < ApplicationRecord
  belongs_to :project
end
```
The foreign key will be on the `issues` table and will be referencing the primary key column on the `projects` table.

## 4

`Animal` class:
```ruby
class Animal < ApplicationRecord
  bleongs_to :zoo
end
```
DB schema for `animals`:
```ruby
create_table :animals do |t|
  t.belongs_to :zoo, foreign_key: true, null: false
  t.timestamps
end
```
Methods for the zoo related to animals:

```ruby
zoo.animals               # getter, retrieves animals at that zoo
zoo.animals = new_animals # setter, re-assigns new_animals to be the animals for the zoo, deletes ones not in new_animals
zoo.animals << zebra
zoo.animals.destroy(zebra)
```
The full list of methods is here: https://guides.rubyonrails.org/association_basics.html#has-many-association-reference

New animal named `jumpster` for `San Diego Zoo`:
```ruby
jumpy = Animal.create(name: 'jumpster')
sd_zoo = Zoo.find_by(name: 'San Diego')
sd_zoo.animals << jumpy
```
## What is mass assignment? What's the non-mass assignment way of setting values?

Mass-assignment is the process of creating an object from a hash of values. One can also set values with `update_attribute` or `update`, or with standard assignment.

## Suppose Animal is an ActiveRecord model. What does this code do? Animal.first

This retrieves the first row from the `animals` table.

## If I have a table called "animals" with a column called "name", and a model called Animal, how do I instantiate an animal object with name set to "Joe". Which methods makes sure it saves to the database?

```ruby
# first method, create makes sure it saves to database

Animal.create(name: 'Joe')

# second method, save without ! suffix will not force db write

joe = Animal.new(name: 'Joe')
joe.save 
```
## How does a M:M association work at the database level?

A M:M association requires an intermediary table to hold foreign keys for both of the tables which have many instances of one another.

For instance, a `book` has many `themes`. A `theme` can be present in many `books`. The table `book_themes` is created to have rows which represent the themes that a certain book has, and the books that a theme is present in.

```ruby
# migration
create_table :book_themes do |t|
  t.belongs_to :book, foreign_key: true
  t.belongs_to :theme, foreign_key: true
end

# model
class BookTheme < ApplicationRecord
  belongs_to :book
  bleongs_to :theme
end

class Book < ApplicationRecord
  has_many :book_themes
  has_many :themes, through: :book_themes
end
```
The `book` instances have many `themes` through the `book_themes` table. The same is true for the `themes` model but just with the inverse code.

## What are the two ways to support a M:M association at the ActiveRecord model level? Pros and cons of each approach?

One can use the `has_and_belongs_to_many` association or the previous approach I detailed above.

If the models need validations, callbacks or extra attributes you should use the first approach. Use `has_and_belongs_to_many` if you don't need to do anything with the model.

## Suppose we have a User model and a Group model, and we have a M:M association all set up. How do we associate the two?

1. Generate migration for `UserGroups`.

```ruby
create_table :user_groups do |t|
  t.belongs_to :user, foreign_key: true
  t.belongs_to :group, foreign_key: true
end
```

2. Assign associations.

```ruby
class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group
end

class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups
end

class Group < ApplicationRecord
  has_many :user_groups
  has_many :users, through: :user_groups
end
```

3. Execute `rails db:migrate`.
