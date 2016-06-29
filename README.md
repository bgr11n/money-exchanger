# Money-Exchanger

Money-Exchanger is a simple lib which allow you exchange money into coins.

# Usage
Initialize Exchanger::ATM with the coins

```ruby
  exchanger = Exchanger::ATM.new(1 => 10, 2 => 10, 5 => 10, 10 => 10, 25 => 10, 50 => 10)
```

Exchange 200:

```ruby
  exchanger.exchange(200) # { 50 => 4 }
```
