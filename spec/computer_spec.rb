require "rspec"
require "./computer"
require "./ds"

RSpec.describe Computer do
  let(:ds) { instance_double("DS") }
  subject(:computer) {
    allow(ds).to receive_messages(
                   :get_mouse_info => "IBM Mouse",
                   :get_mouse_price => 24,
                   :get_keyboard_info => "Gaming Keyboard",
                   :get_keyboard_price => 160
                 )
    Computer.new(1, ds)
  }

  describe "Has working interface that matches each component" do
    let(:valid_components) { [:mouse, :keyboard, :display, :cpu] }
    let(:invalid_components) { [:bluetooth, :printer]}
    it "respond to valid components" do
      aggregate_failures do
        valid_components.each { |component| expect(computer.respond_to?(component)).to eq(true)}
      end
    end

    it "does not respond to invalid components" do
      aggregate_failures do
        invalid_components.each { |component| expect(computer.respond_to?(component)).to eq(false)}
      end
    end
  end

  describe "Responses" do
    it "displays correct price" do
      aggregate_failures do
        expect(computer.mouse).to include("24")
        expect(computer.keyboard).to include("160")
      end
    end

    it "displays correct component information" do
      aggregate_failures do
        expect(computer.mouse).to include("IBM Mouse")
        expect(computer.keyboard).to include("Gaming Keyboard")
      end
    end

    it "display information in correct format" do
      aggregate_failures do
        expect(computer.keyboard.chars.first).to eq("*")
        expect(computer.mouse.chars.first).not_to eq("*")
      end
    end
  end
end