require_relative '../../../lib/calendar/formatters/format_factory'
describe 'Test formatters' do
  let(:formatter) { FormatFactory.new.create('') }

  it 'returns bold when given a holiday tag' do
    formatter.style(:holiday).must_equal 'bold'
  end

  it 'returns leap-day when given a leap tag' do
    formatter.style(:leap).must_equal 'leap-day'
  end

  it 'returns friday-13 when given a friday13 tag' do
    formatter.style(:friday13).must_equal 'friday-13'
  end

  it 'returns "" for anything else' do
    formatter.style(:schmoobles).must_equal ''
  end
end
