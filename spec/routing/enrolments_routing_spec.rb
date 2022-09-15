require "rails_helper"

RSpec.describe EnrolmentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/enrolments").to route_to("enrolments#index")
    end

    it "routes to #new" do
      expect(get: "/enrolments/new").to route_to("enrolments#new")
    end

    it "routes to #show" do
      expect(get: "/enrolments/1").to route_to("enrolments#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/enrolments/1/edit").to route_to("enrolments#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/enrolments").to route_to("enrolments#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/enrolments/1").to route_to("enrolments#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/enrolments/1").to route_to("enrolments#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/enrolments/1").to route_to("enrolments#destroy", id: "1")
    end
  end
end
