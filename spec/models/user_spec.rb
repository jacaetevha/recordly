describe User do
  describe "Validations" do

    def new_user **options
      User.new({name: 'user', email: 'user@example.com'}.merge options)
    end

    def create_user **options
      User.create({name: 'user', email: 'user@example.com'}.merge options)
    end

    context "on a new user" do
      it "should not be valid without a password" do
        user = new_user password: nil, password_confirmation: nil
        expect(user).not_to be_valid
      end

      it "should not be valid with a short password" do
        user = new_user password: 'short', password_confirmation: 'short'
        expect(user).not_to be_valid
      end

      it "should not be valid with a confirmation mismatch" do
        user = new_user password: 'short', password_confirmation: 'not-short'
        expect(user).not_to be_valid
      end

      it "should not be valid with a blank name" do
        user = new_user password: 'longenuf', password_confirmation: 'longenuf', name: ''
        expect(user).not_to be_valid
      end

      it "should not be valid with a nil name" do
        user = new_user password: 'longenuf', password_confirmation: 'longenuf', name: nil
        expect(user).not_to be_valid
      end

      it "should not be valid with a blank email" do
        user = new_user password: 'longenuf', password_confirmation: 'longenuf', email: ''
        expect(user).not_to be_valid
      end

      it "should not be valid with a nil email" do
        user = new_user password: 'longenuf', password_confirmation: 'longenuf', email: nil
        expect(user).not_to be_valid
      end
    end

    context "on an existing user" do
      let(:user) do
        u = create_user password: 'password', password_confirmation: 'password'
        User.find u.id
      end

      it "should be valid with no changes" do
        expect(user).to be_valid
      end

      it "should not change the password when an empty password is given" do
        original_password_digest = user.password_digest
        user.password = user.password_confirmation = ""
        expect(user).to be_valid
        user.save
        expect(user).to be_valid
        expect(original_password_digest).to eq user.password_digest
      end

      it "should be valid with a new (valid) password" do
        user.password = user.password_confirmation = "new password"
        expect(user).to be_valid
      end
    end
  end
end
