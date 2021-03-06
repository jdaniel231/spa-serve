require 'rails_helper'

RSpec.describe JsonWebToken do

  let(:user) { create :user, password: '123123123' }
  let(:token) { token_generator(user.id) }

  describe ".encode" do
    it "returns valid token" do
      encoded = JsonWebToken.encode(user_id: user.id)
      expect(encoded.length).to eq 105
    end
  end # describe ".encode"

  describe ".decode" do
    it "returns payload content" do
      decoded = JsonWebToken.decode(token)
      expect(decoded[:user_id]).to eq user.id
    end
  end # describe ".decode"
end