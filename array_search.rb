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
    pointer_left = 0
    pointer_right = k - 3
    found << array[pointer_left] + 1 if array[pointer_right] - array[pointer_left] == 2 && pointer_right - pointer_left == 1
    while found.size < 2 do
      pointer = (pointer_right - pointer_left) / 2 + pointer_left
      if middle?(pointer)
        found << quicksearch_one(pointer_left, pointer) unless left_found
        found << quicksearch_one(pointer, pointer_right, 1) unless right_found
      elsif left?(pointer)
        pointer_left = pointer
      elsif right?(pointer, 1)
        pointer_right = pointer
      end
      found << array[pointer_left] + 1 if  pointer_right - pointer_left == 1 && array[pointer_right] - array[pointer_left] == 2
      found = [array[pointer_left] + 1, array[pointer_left] + 2] if  pointer_right - pointer_left == 1 && array[pointer_right] - array[pointer_left] == 3
    end
    found
  end

  def quicksearch_one(left, right, base = 0)
    while true do
      middle = (right - left) / 2 + left
      if left?(middle, base)
        left = middle
      elsif right?(middle, base)
        right = middle
      end
      return array[left] + 1 if right - left == 1
    end
  end

  private

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
