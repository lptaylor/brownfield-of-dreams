require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  it 'when destroyed will destroy all videos that belong to the tutorial as well' do
    tutorial_1 = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial_1.id)
    video_2 = create(:video, tutorial_id: tutorial_1.id)

    expect(tutorial_1.videos.count).to eq(2)
    expect { tutorial_1.destroy }.to change { Video.count }.by(-2)
  end
end
