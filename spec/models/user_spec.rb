require "spec_helper"

describe User do
  it "generates a remember token after create" do
    user = build :user
    expect { user.save! }.to change { user.remember_token }
  end
end
