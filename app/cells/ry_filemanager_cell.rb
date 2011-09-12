class RyFilemanagerCell< Cell::Rails
  include Yard
  
  def image_widget(args)
    @options = args[:options]
    @snip_id = args[:snip_id]
    @file_item = Saphira::FileItem.find(@options[:file_item_id]) if @options[:file_item_id]
    @image = nil
    if @file_item
      if @file_item.file.image? and @options[:image_variant]
        @image = @file_item.image_variant(@options[:image_variant])
      else
        @image = @file_item.file
      end
    end
    render
  end
end