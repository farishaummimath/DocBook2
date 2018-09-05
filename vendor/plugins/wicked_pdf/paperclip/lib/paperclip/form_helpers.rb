module Paperclip::FormHelper
  def add_policies
    policy_helper = PolicyHelper.new#(options)
    # initialize the hidden form fields
    hidden_form_fields = {
      :key => '',
      #        'Content-Type' => '',
      :AWSAccessKeyId => Config.access_key_id,
      :acl => policy_helper.options[:acl],
      :policy => policy_helper.policy_document,
      :signature => policy_helper.upload_signature,
      :success_action_status => '201',
      #          :max_file_size => max_file_size,
      #          :file_types => file_types
    }
      
    hidden_form_fields.map do |name, value|
      hidden_field_tag(name, value)
    end.join.html_safe
  end

  def is_s3_enabled?(object_name,method)
    s3_enabled=false
    if File.exist?("#{Rails.root}/config/amazon_s3.yml")
      if object_name.present?
        begin
          if((object_name.send(method).instance_variable_get '@storage').to_s == 's3')
            s3_enabled=true
          end
        rescue Exception => e
        end
      end
    end
    return s3_enabled
  end

  def default_file_upload(object_name, method, options = {})
    on_change=options[:onchange].to_s.dup
    options.delete(:onchange)
    options['onchange'] = "paperclip_file_upload(event,this);#{on_change};"
    label_field_name = "field_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method.to_s}"
    "<div class='paperclip_field'>
          <input id='#{label_field_name}' class='field1' type='text' disabled value='"+t('no_file_selected')+"' default='"+t('no_file_selected')+"'>
              <div class='style'>"+
      ::ActionView::Helpers::InstanceTag.new(object_name, method, self, options.delete(:object)).to_input_field_tag("file", options).html_safe + "" +
      "</div></div>"
  end

  def paperclip_file_field(object_name, method, options = {})    
    object = options[:object]
    if is_s3_enabled?(object,method)
      max_file_size = object.send(method).instance_variable_get '@max_file_size'
      file_types = object.send(method).instance_variable_get '@permitted_file_types'
      policy_options = {:max_file_size => max_file_size, :file_types => file_types }
      policy_helper = PolicyHelper.new(policy_options)      
      options[:direct]= options[:direct].present? ? options[:direct] : (object.send(method).instance_variable_get('@styles').present? ? "true"  : "false")
      # initialize the hidden form fields
      hidden_form_fields = {
        "key_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => '',
        "AWSAccessKeyId_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => options[:access_key_id] || Config.access_key_id,
        "acl_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => policy_helper.options[:acl],
        "policy_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => policy_helper.policy_document,
        "signature_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => policy_helper.upload_signature,
        "success_action_status_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => '201',
        "#{object.class}_max_file_size" => max_file_size,
        "#{object.class}_file_types" => file_types
      }
      # assume that all of the non-documented keys are
      _html_options = options.reject { |key, val| [:access_key_id, :acl, :max_file_size, :bucket].include?(key) }
      options["value"] = ''
      options['class'] = 'paper'
      on_change=options[:onchange].to_s.dup
      options.delete(:onchange)
      options['onchange'] = "paperclip_file_upload(event,this);#{on_change}"
        
      # adds hidden fields for s3 uploads data
      error_name = "error_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}"
      label_field_name = "field_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}"
      progressbar_name = "progressbar_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}"
      progressbar_out_name = "progressbarout_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}"
      progressbar_in_name = "progressbarin_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}"
      hidden_options=options.dup
      hidden_options['class'] = 'hidden_field'
      paperclip_field = "<div class='paperclip_field'>
          <input id='#{label_field_name}' class='field1' type='text' disabled value='"+t('no_file_selected')+"' default='"+t('no_file_selected')+"'>
          <div class='pgbar' id='#{progressbar_name}'>
            <div class='outpg' id='#{progressbar_out_name}'>
               <div class='pg' id='#{progressbar_in_name}'></div>
            </div>
          </div>
          <div class='style'>" 
      if !options[:direct] or options[:direct] == "false"
        paperclip_field += hidden_form_fields.map do |name, value|
          hidden_field_tag(name, value)
        end.join.html_safe + "" 
        
        paperclip_field += ActionView::Helpers::InstanceTag.new(object_name, method, self, hidden_options.delete(:object)).to_input_field_tag("file", hidden_options).html_safe + "" 
      end
      paperclip_field += ActionView::Helpers::InstanceTag.new(object_name, method, self, options.delete(:object)).to_input_field_tag("file", options).html_safe + "" 
      paperclip_field += "</div></div><div id='#{error_name}' class='s3_error'>File not supported or larger in size</div>"
      paperclip_field
    else
      default_file_upload(object_name, method, options)
    end

  end

  def paperclip_file_field_tag(object_name, method, options = {})
    object = options[:object]
    if is_s3_enabled?(object,method)
      max_file_size = object.send(method).instance_variable_get '@max_file_size'
      file_types = object.send(method).instance_variable_get '@permitted_file_types'
      options.update(:max_file_size => max_file_size)
      options.update(:file_types => file_types)
      policy_helper = PolicyHelper.new(options)
      options[:direct]= options[:direct].present? ? options[:direct] : (object.send(method).instance_variable_get('@styles').present? ? "true"  : "false")
      # initialize the hidden form fields
      hidden_form_fields = {
        "key_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => '',
        "AWSAccessKeyId_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => options[:access_key_id] || Config.access_key_id,
        "acl_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => policy_helper.options[:acl],
        "policy_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => policy_helper.policy_document,
        "signature_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => policy_helper.upload_signature,
        "success_action_status_#{object_name.to_s.split('[').join('_').split(']').join('')}_#{method}".to_sym => '201',
        "#{object.class}_max_file_size" => max_file_size,
        "#{object.class}_file_types" => file_types
      }

      # assume that all of the non-documented keys are
      _html_options = options.reject { |key, val| [:access_key_id, :acl, :max_file_size, :bucket].include?(key) }

      options["value"] = ''
      options['class'] = 'paper'
      on_change=options[:onchange].to_s.dup
      options.delete(:onchange)
      options['onchange'] = "paperclip_file_upload(event,this);#{on_change}"
   
      # adds hidden fields for s3 uploads data
      error_name = "error_#{object_name.split('[').join('_').split(']').join('')}_#{method.to_s}"
      label_field_name = "field_#{object_name.split('[').join('_').split(']').join('')}_#{method.to_s}"
      progressbar_name = "progressbar_#{object_name.split('[').join('_').split(']').join('')}_#{method.to_s}"
      progressbar_out_name = "progressbarout_#{object_name.split('[').join('_').split(']').join('')}_#{method.to_s}"
      progressbar_in_name = "progressbarin_#{object_name.split('[').join('_').split(']').join('')}_#{method.to_s}"
      options.delete(:object)
      hidden_options=options.dup
      hidden_options['class'] = 'hidden_field'
      paperclip_field = "<div class='paperclip_field'>
          <input id='#{label_field_name}' class='field1' type='text' disabled disabled value='"+t('no_file_selected')+"' default='"+t('no_file_selected')+"'>
          <div class='pgbar' id='#{progressbar_name}'>
            <div class='outpg' id='#{progressbar_out_name}'>
               <div class='pg' id='#{progressbar_in_name}'></div>
            </div>
          </div>
          <div class='style'>" 
      if !options[:direct] or options[:direct] == 'false'
        paperclip_field += hidden_form_fields.map do |name, value|
          hidden_field_tag(name, value)
        end.join.html_safe + "" 
        paperclip_field += text_field_tag("#{object_name}[#{method}]", nil, hidden_options.update("type" => "file")).html_safe + ""
      end
        paperclip_field += text_field_tag("#{object_name}[#{method}]", nil, options.update("type" => "file")) + "" 
        paperclip_field += "</div></div><div id='#{error_name}' class='s3_error'>File not supported or larger in size</div>"
    else
      default_file_upload(object_name, method, options)
    end

  end


end

module ActionView
  module Helpers
    class FormBuilder
      def paperclip_file_field(method, options = {})
        @template.paperclip_file_field(@object_name, method, options.merge(:object => @object))
      end
    end
  end
end
