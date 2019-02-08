require "rails_helper"

RSpec.describe ConfirmationMailer, type: :mailer do
  describe "new_record_notification" do
    let(:mail) { ConfirmationMailer.success(create(:user)) }

    it "renders the headers" do
      expect(mail.subject).to eq("Activate Turing Tutorials Account!")
      expect(mail.to).to eq([User.last.email])
      expect(mail.from).to eq(["lance.taylor98@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to have_content("Thanks for Joining Turing Tutorials")
    end
  end

end
