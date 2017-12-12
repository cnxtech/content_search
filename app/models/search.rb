# frozen_string_literal: true

# Solr search model
class Search
  attr_reader :id, :q

  def self.client
    RSolr.connect(url: Settings.solr.url)
  end

  def initialize(id:, q:)
    @id = id
    @q = q
  end

  def highlights
    response['highlighting'].map do |id, fields|
      [id, fields['ocrtext']]
    end.to_h
  end

  private

  def response
    @response ||= self.class.client.get(Settings.solr.path, params: {
                                          q: q,
                                          fq: ["druid:#{id}"],
                                          rows: 0,
                                          hl: true,
                                          'hl.fl' => 'ocrtext',
                                          'hl.method' => 'unified'
                                        })
  end
end