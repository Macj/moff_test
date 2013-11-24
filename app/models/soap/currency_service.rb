# # encoding: utf-8
# require 'handsoap'

# class Soap::CurrencyService < Handsoap::Service
#   endpoint EXAMPLE_SERVICE_ENDPOINT
#   def on_create_document(doc)
#     # register namespaces for the request
#     doc.alias 'tns', "http://example.org/ws/spec"
#   end
#   def on_response_document(doc)
#     # register namespaces for the response
#     doc.add_namespace 'ns', 'http://example.org/ws/spec'
#   end

#   # public methods
#   def update_icon!(icon)
#   response = invoke("tns:UpdateIcon") do |message|
#     build_icon!(message, icon)
#   end
#   parse_icon(response/"//icon").first)
# end

# def build_icon!(message, icon)
#   message.add "icon" do |i|
#     i.set_attr "href", icon[:href]
#     i.set_attr "type", icon[:type]
#   end
# end

# def parse_icon(node)
#   { :href => (node/"@href").to_s, :type => (node/"@type").to_s }
# end
#   # todo

#   private
#   # helpers
#   # todo
# end