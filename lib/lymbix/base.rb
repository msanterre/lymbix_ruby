module Lymbix

=begin rdoc
The Base class is the main class used in the Lymbix gem.
It incorporates all the methods used to tonalize.

To begin using the base class, you must get your authentication key provided from Lymbix.com and store the key in the @auth_key variable. 
=end

  class Base
    # The user's authentication key
    attr_accessor :auth_key
    # API version to use
    attr_accessor :api_version
    
    def initialize(auth_key)
        @auth_key = auth_key
        @api_version = 2.3
    end
     
    # Tonalizes text using version 2.1,2.2 of ToneAPI
    def tonalize(article, return_fields = nil, accept_type = nil, article_reference_id = nil)
      return_fields = [] if return_fields == nil
      accept_type = "application/json" if accept_type == nil
      article_reference_id = "" if article_reference_id == nil
      response = request(:post, 'tonalize',{:article => article, :return_fields => return_fields.to_json, :reference_id => article_reference_id.to_s}, {:accept => accept_type}).data
    end
    
    # Tonalizes text using version 2.0 of ToneAPI
    def tonalize_article(article, accept_type = "application/json")
      response = request(:post, 'tonalize_article',{:article => article}, {:accept => accept_type}).data
    end
        
    # Tonalizes mutliple articles using version 2.1 of ToneAPI. With the return_fields param you can now specify which field to get back from the API.
    def tonalize_multiple(articles, return_fields = nil, accept_type = nil, article_reference_ids = nil)
      return_fields = [] if return_fields == nil
      accept_type = "application/json" if accept_type == nil
      article_reference_ids = [] if article_reference_ids == nil
      article_reference_ids.each_with_index {|article,index| article_reference_ids[index] = article.to_s} if article_reference_ids.size > 0
      response = request(:post, 'tonalize_multiple',{:articles => articles.to_json, :return_fields => return_fields.to_json, :article_reference_ids => article_reference_ids.to_json}, {:accept => accept_type}).data
    end
    
    # Tonalizes article using version 2.1 of ToneAPI. With the return_fields param you can now specify which field to get back from the API.
    # The detailed response includes the tonalization data for the article and all sentences found in the article
    def tonalize_detailed(article, return_fields = nil, accept_type = nil, article_reference_id = nil)
      return_fields = [] if return_fields == nil
      accept_type = "application/json" if accept_type == nil
      article_reference_id = "" if article_reference_id == nil
      response = request(:post, 'tonalize_detailed',{:article => article, :return_fields => return_fields.to_json, :article_reference_id => article_reference_id}, {:accept => accept_type}).data
    end
    
    # Flags a phrase to be re-evaluated
    def flag_response(reference_id, phrase, api_method_requested, api_version, callback_url = nil)
      response = request(:post, 'flag_response', {:reference_id => reference_id, :phrase => phrase, :api_method_requested => api_method_requested, :api_version => api_version, :callback_url => callback_url}).data
    end
    
    private
    def request(action, method, data, headers = {})
      Lymbix::Request.new(action, method, {:app_id => @app_id, :auth_key => @auth_key, :version => @api_version, :accept_type => headers[:accept]}, data).run
    end
    
    def article_reference_ids_xml(article_reference_ids)
      xml = "<?xml version='1.0' encoding='utf-8' ?>"
      xml << "<article_reference_ids>"
      article_reference_ids.each {|field| xml << "<article_reference_id>" + field + "</article_reference_id>"}
      xml << "</article_reference_ids>"
      xml
    end
    
    def article_reference_ids_json(article_reference_ids)
      article_reference_ids.to_json
    end
    
    def return_fields_xml(return_fields)
      xml = "<?xml version='1.0' encoding='utf-8' ?>"
      xml << "<return_fields>"
      return_fields.each {|field| xml << "<field>" + field + "</field>"}
      xml << "</return_fields>"
      xml
    end
    
    def return_fields_json(return_fields)
      return_fields.to_json
    end
    
    def articles_xml(articles)
      xml = "<?xml version='1.0' encoding='utf-8' ?>"
      xml = "<articles>"
      articles.each {|article| xml << "<article>" + article + "</article>"}
      xml << "</articles>"
      xml
    end
    
    def articles_json(articles)
      articles.to_json
    end
  end

end