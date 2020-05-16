require "rails_helper"

RSpec.describe ChefMailer, type: :mailer do
  let!(:chef) { FactoryBot.create(:chef) }

  describe 'registration_email' do\
    let(:mail) do
      described_class.with(chef: chef).registration_confirmation.deliver_now
    end

    it 'renders email' do
      expect(mail.subject).to eq('Registration Confirmation')
      expect(mail.to).to eq([chef.email])
      expect(mail.from).to eq(['HomeChef@no-reply.com'])
    end

    it 'sends registration link' do
      expect(mail.body.encoded)
        .to match("#{ENV['HOST_URL']}/chefs/#{chef.confirm_token}/confirm_email")
    end
  end
end
