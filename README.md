# Calculator Challenge

Your challenge is to implement an infix calculator for integers with 4 operators as a Ruby function.

The input to the function will be a string containing integers and operators ("*", "/", "+", and "-"). These tokens will be separated by spaces. If you encounter invalid input you should raise an `ArgumentError`.

The calculator should follow the normal [order of operations][] associativity rules.

[order of operators]: https://en.wikipedia.org/wiki/Order_of_operations#Definition

## Valid Input Examples

- "4 + 4" ⇒ 8
- "2 * 2 + 4" ⇒ 8
- "6 / 3 - 2 * -4" ⇒ 10

## Invalid Input Examples

- "4 + four" raises `ArgumentError`
- "4 - - 4" raises `ArgumentError`
- "4 ^ 4" raises `ArgumentError`
- "4 ** 4" raises `ArgumentError`