module SimpleSpark
  module Endpoints
    # Provides access to the /metrics endpoint
    # @note See: https://developers.sparkpost.com/api/#/reference/metrics
    class Metrics
      attr_accessor :client

      def initialize(client)
        @client = client
      end

      # The Metrics API is designed for discoverability of child links. Calling the API root displays a list of URIs that exists within the Metrics API.
      # @return [Hash] containg a Metrics hash, the 'links' key will contain the links
      # @note See: https://developers.sparkpost.com/api/#/reference/metrics/metrics-discoverability-links
      def discoverability_links
        @client.call(method: :get, path: 'metrics', extract_results: false)
      end

      # Deliverability Metrics Summary
      # @param values [Hash] the values to query with
      # @note dates from and to should be converted using strftime('%Y-%m-%dT%H:%M')
      # @return [Hash] containg a Metrics hash, the 'results' key will contain the metrics, the 'links' key will contain discoverability links
      # @note Example:
      #   client.metrics.deliverability_metrics_summary(from: '2013-04-20T07:12', to: '2018-04-20T07:12', metrics: 'count_accepted', timezone: 'America/New_York')
      # @note See: https://developers.sparkpost.com/api/#/reference/metrics/discoverability-links/deliverability-metrics-summary
      def deliverability_metrics_summary(values)
        @client.call(method: :get, path: 'metrics/deliverability', query_values: values, extract_results: false)
      end

      # Deliverability Metrics By Domain
      # @param values [Hash] the values to query with
      # @note dates from and to should be converted using strftime('%Y-%m-%dT%H:%M')
      # @return [Array] containg Metrics results i.e. { "count_accepted": 66, "domain": "gmail.com" }
      # @note Example:
      #   client.metrics.deliverability_metrics_by_domain(from: '2013-04-20T07:12', to: '2018-04-20T07:12', metrics: 'count_accepted', timezone: 'America/New_York', domains: 'gmail.com')
      # @note See: https://developers.sparkpost.com/api/#/reference/metrics/deliverability-metrics/deliverability-metrics-by-domain
      def deliverability_metrics_by_domain(values)
        @client.call(method: :get, path: 'metrics/deliverability/domain', query_values: values)
      end

      # Deliverability Metrics By Sending Domain
      # @param values [Hash] the values to query with
      # @note dates from and to should be converted using strftime('%Y-%m-%dT%H:%M')
      # @return [Array] containg Metrics results i.e. { "count_accepted": 66, "sending_domain": "gmail.com" }
      # @note Example:
      #   client.metrics.deliverability_metrics_by_sending_domain(from: '2013-04-20T07:12', to: '2018-04-20T07:12', metrics: 'count_accepted', timezone: 'America/New_York', sending_domains: 'mydomain.com')
      # @note See: https://developers.sparkpost.com/api/#/reference/metrics/deliverability-metrics/deliverability-metrics-by-sending-domain
      def deliverability_metrics_by_sending_domain(values)
        @client.call(method: :get, path: 'metrics/deliverability/sending-domain', query_values: values)
      end

      # Deliverability Metrics By Campaign
      # @param values [Hash] the values to query with
      # @note dates from and to should be converted using strftime('%Y-%m-%dT%H:%M')
      # @return [Array] containg Metrics results i.e. { "count_accepted": 66, "campaign_id": "Summer Sale" }
      # @note Example:
      #   client.metrics.deliverability_metrics_by_campaign(from: '2013-04-20T07:12', to: '2018-04-20T07:12', metrics: 'count_accepted', timezone: 'America/New_York', campaigns: 'Summer Sale')
      # @note See: https://developers.sparkpost.com/api/#/reference/metrics/deliverability-metrics/deliverability-metrics-by-campaign
      def deliverability_metrics_by_campaign(values)
        @client.call(method: :get, path: 'metrics/deliverability/campaign', query_values: values)
      end

      # Deliverability Metrics By Subaccount
      # @param values [Hash] the values to query with
      # @note dates from and to should be converted using strftime('%Y-%m-%dT%H:%M')
      # @return [Array] containg Metrics results i.e. { "count_accepted": 66, "subaccount_id": "acc123" }
      # @note Example:
      #   client.metrics.deliverability_metrics_by_subaccount(from: '2013-04-20T07:12', to: '2018-04-20T07:12', metrics: 'count_accepted', timezone: 'America/New_York', subaccounts: 'acc123')
      # @note See: https://developers.sparkpost.com/api/#/reference/metrics/deliverability-metrics/deliverability-metrics-by-subaccount
      def deliverability_metrics_by_subaccount(values)
        @client.call(method: :get, path: 'metrics/deliverability/subaccount', query_values: values)
      end

      # Deliverability Metrics By Template
      # @param values [Hash] the values to query with
      # @note dates from and to should be converted using strftime('%Y-%m-%dT%H:%M')
      # @return [Array] containg Metrics results i.e. { "count_accepted": 66, "template": "My Template" }
      # @note Example:
      #   client.metrics.deliverability_metrics_by_template(from: '2013-04-20T07:12', to: '2018-04-20T07:12', metrics: 'count_accepted', timezone: 'America/New_York', subaccounts: 'acc123')
      # @note See: https://developers.sparkpost.com/api/#/reference/metrics/deliverability-metrics/deliverability-metrics-by-template
      def deliverability_metrics_by_template(values)
        @client.call(method: :get, path: 'metrics/deliverability/template', query_values: values)
      end
    end
  end
end
