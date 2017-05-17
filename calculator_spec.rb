require 'rspec/autorun'
require_relative 'calculator'

describe 'calculator' do
  it 'handles nil' do
    expect{ Calculator.new(nil).evaluate }.to raise_error(ArgumentError)
  end

  it 'handles basic addition' do
    expect(Calculator.new('4 + 4').evaluate).to eq(8)
  end

  it 'handles basic subtraction' do
    expect(Calculator.new('4 - 2').evaluate).to eq(2)
  end

  it 'handles complex addition' do
    expect(Calculator.new('1 + 2 + 3').evaluate).to eq(6)
  end

  it 'handles complex subtraction' do
    expect(Calculator.new('7 - 2 - 3').evaluate).to eq(2)
  end

  it 'handles floats' do
    expect(Calculator.new('5.3 + 4.7').evaluate).to eq(10)
  end

  it 'handles division' do
    expect(Calculator.new('10 / 2').evaluate).to eq(5)
  end

  it 'handles multiplication' do
    expect(Calculator.new('10 * 2').evaluate).to eq(20)
  end

  it 'handles mixed operations' do
    expect(Calculator.new('2 + 2 / 4').evaluate).to eq(2.5)
  end

  it 'handles more operations' do
    expect(Calculator.new('2 * 2 + 4').evaluate).to eq(8)
  end

  it 'handles more operations' do
    expect(Calculator.new('6 / 3 - 2 * -4').evaluate).to eq(10)
  end

  it 'handles parentheses' do
    expect(Calculator.new('2 * (10 - 2)').evaluate).to eq(16)
  end

  it 'checks for mismatched parentheses' do
    expect{ Calculator.new('2 * (10 - 2))').evaluate }.to raise_error(ArgumentError)
  end

  it 'handles nested parentheses' do
    expect(Calculator.new('2 * (10 - (2 * 3))').evaluate).to eq(8)
  end

  it 'errors out with exponents' do
    expect{ Calculator.new('2 ^ 4').evaluate}.to raise_error(ArgumentError)
  end

  it 'errors out with ruby exponents' do
    expect{ Calculator.new('2 ** 4').evaluate }.to raise_error(ArgumentError)
  end

  it 'errors out with triple ruby exponents' do
    expect{ Calculator.new('2 *** 4').evaluate }.to raise_error(ArgumentError)
  end

  it 'errors out with non allowed characters' do
    expect{ Calculator.new('5 + 3;').evaluate }.to raise_error(ArgumentError)
  end

  it 'errors out with non allowed word characters' do
    expect{ Calculator.new('5 + three').evaluate }.to raise_error(ArgumentError)
  end

  it 'errors out with double negation' do
    expect{ Calculator.new('5 -- 2').evaluate }.to raise_error(ArgumentError)
  end
end