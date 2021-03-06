require_relative '../../../spec_helper'

describe Web::Views::Home::Index do
  let(:repo)          { CalendarEntryRepository.new }
  let(:user_repo)     { UserRepository.new }
  let(:template)      { Hanami::View::Template.new('apps/web/templates/home/index.html.erb') }

  def before_setup
    repo.clear
    user_repo.clear
  end
  
  def exposures(year = 2018, user = nil)
    Hash[
      year: Year.new(year),
      formatter: FormatFactory.new.create(''),
      entry_list: repo,
      format: 'html',
      current_user: user
    ]
  end

  def render(year = 2018, user = nil)
    v = Web::Views::Home::Index.new(template, exposures(year, user))
    v.render
  end

  it 'has 1 year on the index page' do
    render.scan('class="year-wrapper"').count.must_equal 1
  end

  it 'has 12 months on the index page' do
    render.scan('class="month"').count.must_equal 12
  end

  it 'properly highlights leap days' do
    render(2018).scan('class="leap-day"').count.must_equal 0
    rendered2000 = render(2000)
    rendered2000.scan('class="leap-day"').count.must_equal 1
  end

  it 'if there are no calendar entries, displays an empty message' do
    render(2000).scan('There are no calendar entries stored.').count.must_equal 1
  end

  it 'if there are public entries, display them in a list' do
    repo.create_public(name: 'Christmas', month: 12, day: 25)
    repo.create_public(name: 'Remembrance Day', month: 11, day: 11)
    rendered_holidays = render(2000)
    rendered_holidays.scan('2000-12-25 - Christmas').count.must_equal 1
    rendered_holidays.scan('2000-11-11 - Remembrance Day').count.must_equal 1
    rendered_holidays.scan('class="public-entry"').count.must_equal 2
    rendered_holidays.scan('class="private-entry"').count.must_equal 0
  end

  it 'displays public and private entries' do
    user = user_repo.create(name: 'Test1', github_id: '12121212')
    not_me = user_repo.create(name: 'not-me', github_id: '232323')

    repo.create_public(name: 'Christmas', month: 12, day: 25)
    repo.create_public(name: 'Remembrance Day', month: 11, day: 11)
    repo.create_private(name: 'Special Day', month: 12, day: 12, user: not_me)
    repo.create_private(name: 'My Birthday', month: 6, day: 30, user: user)

    rendered = render(2000, user)
    rendered.scan('class="public-entry"').count.must_equal 2
    rendered.scan('class="private-entry"').count.must_equal 1
    rendered.scan('My Birthday').count.must_equal 1
  end
end
