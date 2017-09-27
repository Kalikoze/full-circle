require 'rails_helper'

RSpec.describe Cohort do

  describe 'Associations' do
    it { should have_many(:applications) }
    it { should have_many(:cohort_reviewers) }
    it { should have_many(:users).through(:cohort_reviewers) }
  end

  describe 'State' do

    it 'Defaults to Unfinalized' do
      cohort = create(:cohort)

      assert(cohort.unfinalized?)
    end

    it 'Can be a Finalized' do
      cohort = create(:cohort)

      cohort.finalized!
      assert(cohort.finalized?)
    end
  end

  describe 'Status' do

    it 'Can be open' do
      start_date = Date.today - 1.day
      end_date = start_date + 3.weeks

      cohort = create(:cohort, start_date: start_date, end_date: end_date)

      assert(cohort.open?)
    end

    it 'Can be closed' do
      start_date = Date.today - 3.weeks
      end_date = start_date - 1.day

      cohort = create(:cohort, start_date: start_date, end_date: end_date)

      refute(cohort.open?)
    end

    it 'Can return open status css class' do
      start_date = Date.today - 1.day
      end_date = start_date + 3.weeks

      cohort = create(:cohort, start_date: start_date, end_date: end_date)

      expect(cohort.css_status).to eq('open')
    end

    it 'Can return closed status css class' do
      start_date = Date.today - 3.weeks
      end_date = start_date - 1.day

      cohort = create(:cohort, start_date: start_date, end_date: end_date)

      expect(cohort.css_status).to eq('closed')
    end
  end

  describe 'Scopes' do

    it 'Can return current open cohort' do
      cohort = create(:cohort, :open)
      current = Cohort.current[0]

      expect(current).to eq(cohort)
    end

    it 'Returns Empty if no current open cohort' do
      cohort = create(:cohort, :closed)
      current = Cohort.current

      assert(current.empty?)
    end

  end

  describe 'Helper Methods' do

    it 'Can return all reviewers' do
      cohort = create(:cohort, :open)
      reviewers = create_list(:user, 10, :reviewer)
      students = create_list(:user, 10)

      cohort.users << reviewers << students

      expect(cohort.reviewers.count).to eq(10)
      expect(reviewers).to include(*cohort.reviewers)
      expect(students).not_to include(*cohort.reviewers)
    end

    it 'Can return all students' do
      cohort = create(:cohort, :open)
      reviewers = create_list(:user, 10, :reviewer)
      students = create_list(:user, 10)

      cohort.users << reviewers << students

      expect(cohort.reviewers.count).to eq(10)
      expect(students).to include(*cohort.students)
      expect(reviewers).not_to include(*cohort.students)
    end
  end
end