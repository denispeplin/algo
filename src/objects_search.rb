require 'byebug'
require 'facets'

class People
  attr_reader :data
  attr_accessor :index

  def initialize(size)
    # gender, age, height, code, wealth
    @data = (1..size).map do
      [
        [true, false].sample,
        rand(100),
        rand(300),
        rand(1_000_000),
        rand(0.0..1_000_000.0)
      ]
    end
  end

  def make_index
    self.index = (0..4).map { |position| prepare_data(position) }

    (0..4).each do |position|
      data.each_with_index do |item, data_index|
        # it is 2x faster to have separate accessors
        self.index[position][item[position]].push data_index
      end
    end
  end

  # That's slow!
  # TODO: try to search by separate keys array and use values_at for hash
  # find_by([true, (1..50), (10..100), (111..10000), (10000..200000)])
  def find_by(params)
    results = params.each_with_index.map do |param, position|
      if param.nil?
        nil
      elsif param.respond_to?(:include?)
        index[position].select { |key, _| param.include? key }.values.flatten
      else
        index[position].select { |key, _| param == key }.values.flatten
      end
    end.compact.inject(:&)
    data.values_at(*results)
  end

  private

  def prepare_data(position)
    data.map { |item| [item[position], []] }.to_h
  end
end
