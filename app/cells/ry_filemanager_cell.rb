class RyFilemanagerCell< Cell::Rails
  include Yard
  
  def image_widget(args)
    @options = args[:options]
    @snip_id = args[:snip_id]
    @file_item = Saphira::FileItem.find(@options[:file_item_id]) if @options[:file_item_id]
    @image = nil
    if @file_item and @file_item.file_uid
      if @file_item.file.image? and @options[:image_variant]
        @image = @file_item.image_variant(@options[:image_variant])
      else
        @image = @file_item.file
      end
    end
    render
  end
  
  def imageslider_widget(args)
    @options = args[:options]
    @snip_id = args[:snip_id]
    @file_item = Saphira::FileItem.find(@options[:file_item_id]) if @options[:file_item_id]
    @images = []
    if @file_item and @file_item.item_type==Saphira::FileItem::TYPE_FOLDER
      if @options[:recursive]
        @images = @file_item.descendants
      else
        @images = @file_item.children
      end
      @images.select! { |f| f.file_uid and f.file.image? }
      @images.map! { |i| i.image_variant(@options[:image_variant]) }
    end
    render
  end
end