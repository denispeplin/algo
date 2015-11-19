require 'rspec'
require './array_search'

shared_examples_for 'vacancies matcher' do
  specify do
    expect(vacant_search.quicksearch).to match_array(vacancies)
  end
end

describe VacantSearch do
  let(:vacant_search) { VacantSearch.new(array) }

  context 'empty array' do
    let(:array) { [] }
    let(:vacancies) { [1, 2] }

    include_examples 'vacancies matcher'
  end

  context 'first two missing' do
    let(:array) { [3] }
    let(:vacancies) { [1, 2] }

    include_examples 'vacancies matcher'
  end

  context 'first and last missing' do
    let(:array) { [2, 3] }
    let(:vacancies) { [1, 4] }

    include_examples 'vacancies matcher'
  end

  context 'last two missing' do
    let(:array) { [1, 2] }
    let(:vacancies) { [3, 4] }

    include_examples 'vacancies matcher'
  end

  context 'two in the middle missing' do
    let(:array) { [1, 4] }
    let(:vacancies) { [2, 3] }

    include_examples 'vacancies matcher'
  end

  context 'one in the middle missing ' do
    let(:array) { [2, 4] }
    let(:vacancies) { [1, 3] }

    include_examples 'vacancies matcher'
  end

  context 'missing are on the right, separated by one' do
    let(:array) { [1, 2, 4] }
    let(:vacancies) { [3, 5] }

    include_examples 'vacancies matcher'
  end

  context 'missing are separated by two' do
    let(:array) { [1, 3, 4, 6] }
    let(:vacancies) { [2, 5] }

    include_examples 'vacancies matcher'
  end

  context 'missing are on the left, separated by two' do
    let(:array) { [2, 3, 5] }
    let(:vacancies) { [1, 4] }

    include_examples 'vacancies matcher'
  end

  context 'missing are on the right, separated by two' do
    let(:array) { [1, 2, 4, 5] }
    let(:vacancies) { [3, 6] }

    include_examples 'vacancies matcher'
  end

  context 'missing are separated by many' do
    let(:array) { [1, 2, 4, 5, 6, 8, 9, 10] }
    let(:vacancies) { [3, 7] }

    include_examples 'vacancies matcher'
  end

  context 'missing are together in the middle' do
    let(:array) { [1, 2, 3, 4, 7, 8, 9, 10] }
    let(:vacancies) { [5, 6] }

    include_examples 'vacancies matcher'
  end

  context 'missing are together at the left' do
    let(:array) { [1, 2, 5, 6, 7, 8, 9, 10] }
    let(:vacancies) { [3, 4] }

    include_examples 'vacancies matcher'
  end

  context 'missing are together at the right' do
    let(:array) { [1, 2, 3, 4, 5, 6, 9, 10] }
    let(:vacancies) { [7, 8] }

    include_examples 'vacancies matcher'
  end

  context 'thousands' do
    let(:array) { (1..1_000).to_a - vacancies  }
    let(:vacancies) { [133, 856] }

    include_examples 'vacancies matcher'
  end

  context 'tens of thousands' do
    let(:array) { (1..10_001).to_a - vacancies  }
    let(:vacancies) { [1_330, 2_041] }

    include_examples 'vacancies matcher'
  end

  context 'hundreds of thousands' do
    let(:array) { (1..100_000).to_a - vacancies  }
    let(:vacancies) { [1_333, 70_415] }

    include_examples 'vacancies matcher'
  end

  context 'millions' do
    let(:array) { (1..1_000_001).to_a - vacancies  }
    let(:vacancies) { [55_555, 708_415] }

    include_examples 'vacancies matcher'
  end

  context 'tens of millions' do
    let(:array) { (1..10_000_000).to_a - vacancies  }
    let(:vacancies) { [55_557, 9_708_815] }

    include_examples 'vacancies matcher'
  end

  # quick and dirty (but effective) way to test algorithm
  context 'with size passed' do
    specify do
      100.times do
        (2..20).each do |k|
          vacant_search = VacantSearch.new(k)
          expect(vacant_search.quicksearch).to match_array(vacant_search.vacancies)
        end
      end
    end
  end
end
