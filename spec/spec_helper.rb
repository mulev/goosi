require 'minitest/autorun'
require 'minitest/reporters'
require 'goosi'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new(color: true)
