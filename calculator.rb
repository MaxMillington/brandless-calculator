require 'pry'

class Calculator
  attr_accessor :value
  attr_accessor :match_value
  attr_reader :input

  def initialize(input)
    @input = input
    raise ArgumentError if input.nil? || input.class != String || illegal_chars?(input) || !parentheses_match?(input)
  end

  def evaluate(input = @input)
    clean_input = clean_input(input)
    raise ArgumentError unless clean_input
    return format(input) if finished?(input)
    inner_parentheses = clean_input.match(/\(([^()]+)\)/)
    inner_input = inner_parentheses ? inner_parentheses[0] : clean_input

    add_subtract, multiply_divide, value = get_operator_variables(inner_input)

    match_value, value = order_of_operations(add_subtract, multiply_divide, value)

    new_input = match_value ? clean_input.sub(match_value[0], value.to_s) : value
    evaluate(new_input)
  end

  private

  def order_of_operations(add_subtract, multiply_divide, value)
    if value
      match_value = value
      input_with_no_left_paren = match_value[0].sub('(', '')
      value = input_with_no_left_paren.sub(')', '')
    elsif multiply_divide
      match_value = multiply_divide
      value = perform_multiplication_division_calc(match_value) if multiply_divide
    elsif add_subtract
      match_value = add_subtract
      value = perform_addition_subtraction_calc(match_value) if add_subtract
    end
    return match_value, value
  end

  def get_operator_variables(input)
    value = nil
    value = input.match(/\(([^()]+)\)/)  if !input.include?('-') &&
      !input.include?('+') && !input.include?('*') &&
      !input.include?('/')
    multiply_divide = input.match(/([0-9]*\.?[0-9]*)([\*\/])(-?[0-9]*\.?[0-9]*)/)
    add_subtract = input.match(/(\-?[0-9]*\.?[0-9]*)([\+\-])([0-9]*\.?[0-9]*)/)
    return add_subtract, multiply_divide, value
  end

  def finished?(input)
    !input.match(/[+-\/*^]/) || (input.scan(/[+-\/*^]/)[0] == '.' && input.scan(/[+-\/*^]/).size < 2)
  end

  def format(input)
    input = input.to_f
    input.to_i == input ? input.to_i : input
  end

  def perform_addition_subtraction_calc(input)
    return input[1].to_f + input[3].to_f if input[2] == '+'
    return input[1].to_f - input[3].to_f if input[2] == '-'
  end

  def perform_multiplication_division_calc(input)
    return input[1].to_f * input[3].to_f if input[2] == '*'
    return input[1].to_f / input[3].to_f if input[2] == '/'
  end

  def illegal_chars?(input)
    allowed_characters = Regexp.escape( '+-*/.()' )
    spaceless_input = input.gsub(/\s+/, '')
    non_allowed_chars = spaceless_input =~ /[^\d#{allowed_characters}]/
    return true unless non_allowed_chars.nil?
    space_count = input.count(' ')
    return true if space_count <= input.count('*') ||
      space_count <= input.count('/') ||
      space_count <= input.count('+') ||
      space_count <= input.count('-')
    return false
  end

  def clean_input(input)
    spaceless_input = input.gsub(/\s+/, '')
    spaceless_input.gsub('--', '+')
  end

  def parentheses_match?(input)
    input.count('(') == input.count(')')
  end
end