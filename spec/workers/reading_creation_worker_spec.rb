require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe ReadingCreationWorker, type: :worker do
  it "" do
    expect {
      ReadingCreationWorker.perform_async(create(:reading))
    }.to change(ReadingCreationWorker.jobs, :size).by(1)
  end
end
