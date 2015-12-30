require 'rails_helper'

RSpec.describe Record, type: :model do
  let(:user) { new_user }
  let(:record) { Record.create title: "#{article} #{@random_letter}asdflkjasdf", user_id: user.id }

  describe :update do
    let(:article) { "" }
    it "should not allow the record's user to be changed" do
      record.update user_id: user.id + 1
      expect(record.errors[:user_id]).to eq ['Change of user_id not allowed!']
    end
  end

  describe :ordinal_letter do
    shared_examples :ignored_articles_in_record_name do | _article |
      let(:article) { _article }
      (('A'..'Z').to_a + ('a'..'z').to_a).each do |random_letter|
        before :each do
          @random_letter = random_letter
        end
        it { expect(record.ordinal_letter).to eq @random_letter.downcase }
        it { expect(record.title.split.first).to eq _article }
      end
    end

    context 'the article "a"' do
      it_behaves_like :ignored_articles_in_record_name, 'a'
    end

    context 'the article "an"' do
      it_behaves_like :ignored_articles_in_record_name, 'an'
    end

    context 'the article "the"' do
      it_behaves_like :ignored_articles_in_record_name, 'the'
    end

    context 'the title is only an article' do
      let(:a) { Record.create title: 'a', user_id: user.id }
      let(:an) { Record.create title: 'An', user_id: user.id }
      let(:the) { Record.create title: 'THE', user_id: user.id }

      it { expect(a.ordinal_letter).to eq 'a' }
      it { expect(an.ordinal_letter).to eq 'a' }
      it { expect(the.ordinal_letter).to eq 't' }
    end
  end
end
