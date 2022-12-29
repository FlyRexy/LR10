# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context 'when we choose different formats' do
    it 'returns result in html' do
      get 'result', params: { arr: '1 4 9 5 1', num: 5, side: 'client' }
      expect(response.content_type).to eq('text/html; charset=utf-8')
    end

    it 'returns result in xml' do
      get 'result', params: { arr: '1 4 9 5 1', num: 5, side: 'xml' }
      expect(response.content_type).to eq('application/xml; charset=utf-8')
    end

    it 'returns result from server in xml' do
      get 'result', params: { arr: '1 4 9 5 1', num: 5, side: 'server' }
      expect(response.content_type).to eq('application/xml; charset=utf-8')
    end
  end
end
