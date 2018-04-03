require_relative '../../../spec_helper'

describe Web::Views::Date::Display do
  describe 'test normal day' do
    let(:repo)      { CalendarEntryRepository.new }
    let(:formatter) { FormatFactory.new.create(:html) }
    let(:exposures) { Hash[format: :html, date: Date.new(2019, 12, 25), repo: repo, formatter: formatter] }
    let(:template)  { Hanami::View::Template.new('apps/web/templates/date/display.html.erb') }
    let(:view)      { Web::Views::Date::Display.new(template, exposures) }
    let(:rendered)  { view.render }
    it 'exposes all important properties' do
      repo.clear
      view.format.must_equal exposures.fetch(:format)
      view.date.must_equal exposures.fetch(:date)
    end

    it 'displays a header with the entered date' do
      repo.clear
      view.header.must_equal '<div class="title ">December 25, 2019</div>'
    end
  end

  describe 'test holiday' do
    let(:repo)      { CalendarEntryRepository.new }
    let(:formatter) { FormatFactory.new.create(:html) }
    let(:exposures) { Hash[format: :html, date: Date.new(2018, 12, 25), repo: repo, formatter: formatter] }
    let(:template)  { Hanami::View::Template.new('apps/web/templates/date/display.html.erb') }
    let(:view)      { Web::Views::Date::Display.new(template, exposures) }
    let(:rendered)  { view.render }
    it 'displays a holiday header' do
      repo.clear
      repo.create(name: 'Christmas', month: 12, day: 25)
      view.header.must_equal '<div class="title holiday">December 25, 2018</div>'
    end
  end
end
