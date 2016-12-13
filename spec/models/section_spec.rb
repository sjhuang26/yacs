require "rails_helper"

RSpec.describe Section do
	context 'period day, start time, or end time updated' do
		before do
			@section = create(:section, num_periods: 5, 
				periods_day: [3, 5, 2, 2, 4], 
				periods_start: [1200, 800, 1600, 800, 800], 
				periods_end: [1400, 900, 1800, 900, 1000], 
				periods_type: ['LAB', 'LEC', 'TEST', 'LEC', 'LEC'])
		end

		it 'sorts periods by day, and then start time' do 
			expect(@section.num_periods).to eq 5
			expect(@section.periods_day).to eq [2, 2, 3, 4, 5]
			expect(@section.periods_start).to eq [800, 1600, 1200, 800, 800]
			expect(@section.periods_end).to eq [900, 1800, 1400, 1000, 900]
			expect(@section.periods_type).to eq ['LEC', 'TEST', 'LAB', 'LEC', 'LEC']
		end
	end

	context 'all updates excluding period day, start time, and end time' do
		before do
			Section.skip_callback(:sort_periods)
			@section = create(:section, num_periods: 5, 
				periods_day: [3, 5, 2, 2, 4], 
				periods_start: [1200, 800, 1600, 800, 800], 
				periods_end: [1400, 900, 1800, 900, 1000], 
				periods_type: ['LAB', 'LEC', 'TEST', 'LEC', 'LEC'])
			Section.set_callback(:sort_periods)
		end

		if 'does not sort period' do 
			expect(@section.num_periods).to eq 5
			expect(@section.periods_day).to eq [3, 5, 2, 2, 4]
			expect(@section.periods_start).to eq [1200, 800, 1600, 800, 800]
			expect(@section.periods_end).to eq [1400, 900, 1800, 900, 1000]
			expect(@section.periods_type).to eq ['LAB', 'LEC', 'TEST', 'LEC', 'LEC']
		end
	end
end