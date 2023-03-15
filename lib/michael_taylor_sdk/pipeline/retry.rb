# frozen_string_literal: true

require "michael_taylor_sdk/retry_strategy/one_try"

module MichaelTaylorSdk::Pipeline
  class Retry
    def initialize(next_pipeline_stage, retry_strategy)
      @next_pipeline_stage = next_pipeline_stage
      @retry_strategy = retry_strategy
    end

    def execute_http_request(request_details)
      @retry_strategy.run(-> { @next_pipeline_stage.execute_http_request(request_details) })
    end

    def http_response
      @next_pipeline_stage.http_response
    end
  end
end
