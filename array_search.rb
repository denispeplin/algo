class VacantSearch
  attr_reader :k, :array, :vacancies

  # pass array here to ease testing
  def initialize(param)
    if param.is_a?(Array)
      @k = param.size + 2
      @array = param
    else
      @k = param
      @vacancies = get_vacancies
      @array = (1..k).to_a - vacancies
    end
  end

  # would use each_with_object, but it is slower here, roughly 25% loss
  def sequental_search
    found = []
    by_position = 1
    array.each do |i|
      unless by_position == i
        found << by_position
        break if found.size == 2
        by_position += 1
      end
      by_position += 1
    end
    found
  end

  def quicksearch
    found = []
    return [1, 2] if array.empty? || array[0] == 3
    return [k - 1, k] if array[-1] == k - 2
    left_found = true && found << 1 if array[0] == 2
    right_found = true && found << k if array[-1] == k - 1
    left = 0
    right = k - 3
    while true do
      found += get_gaps(left, right) if right - left == 1
      break unless found.size < 2
      pointer = (right - left) / 2 + left
      if middle?(pointer)
        found << quicksearch_one(left, pointer) unless left_found
        found << quicksearch_one(pointer, right, 1) unless right_found
      elsif left?(pointer)
        left = pointer
      elsif right?(pointer, 1)
        right = pointer
      end
    end
    found
  end

  private

  def get_gaps(left, right)
    case array[right] - array[left]
    when 2
      [array[left] + 1]
    when 3
      [array[left] + 1, array[left] + 2]
    else
      []
    end
  end

  def quicksearch_one(left, right, base = 0)
    while true do
      pointer = (right - left) / 2 + left
      if left?(pointer, base)
        left = pointer
      elsif right?(pointer, base)
        right = pointer
      end
      return array[left] + 1 if right - left == 1
    end
  end

  def left?(pointer, base = 0)
    array[pointer] - pointer == 1 + base
  end

  def middle?(pointer)
    array[pointer] - pointer == 2
  end

  def right?(pointer, base = 0)
    array[pointer] - pointer == 2 + base
  end

  def get_vacancies
    a = rand(k) + 1
    b = rand(k) + 1
    while(b == a)
      b = rand(k) + 1
    end
    [a, b]
  end
end
