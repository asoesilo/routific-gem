require_relative './helper/spec_helper'

RSpec.describe Util do
  let(:subject)  { Util }
  let(:endpoint) { "endpoint" }
  let(:url)      { "#{ Util::BASE_URL }#{ endpoint }" }
  let(:headers)  { "HEADERS" }
  let(:data)     { { key: "RESULT" } }

  before do
    expect(subject).to receive(:headers)
      .and_return(headers)
  end

  describe ".send_request" do
    context "GET" do
      let(:method) { "GET" }
      let(:result) { subject.send_request(method, endpoint ) }

      before do
        expect(RestClient::Request).to receive(:execute).with(method: :get, url: url, headers: headers)
          .and_return(data.to_json)
      end

      it "passes the method to RestClient" do
        expect(result['key']).to eq("RESULT")
      end
    end

    context "POST" do
      let(:method) { "POST" }
      let(:result) { subject.send_request(method, endpoint, nil, data ) }

      before do
        expect(RestClient::Request).to receive(:execute).with(method: :post, url: url, payload: data.to_json, headers: headers)
          .and_return(data.to_json)
      end

      it "passes the method to RestClient" do
        expect(result['key']).to eq("RESULT")
      end
    end

    context "product API" do
      let(:method) { "POST" }
      let(:result) { subject.send_request(method, endpoint, nil, data, true ) }
      let(:url)     { "#{ Util::PRODUCT_URL }#{ endpoint }" }

      before do
        expect(RestClient::Request).to receive(:execute).with(method: :post, url: url, payload: data.to_json, headers: headers)
          .and_return(data.to_json)
      end

      it "passes the method to RestClient" do
        expect(result['key']).to eq("RESULT")
      end
    end
  end
end
