module SearchesHelper
	def search(q)
    if @item_type=="all"
      if @q=="*"
        return @space.ideas + @space.projects + @space.surveys + @space.actualities
      else
        return matches(@q, @space.ideas) + matches(@q, @space.projects) + matches(@q, @space.surveys) + matches(@q, @space.actualities)
      end
    else
      if @item_type=="idea"
        items = @space.ideas
      elsif @item_type=="project"
        items = @space.projects
      elsif @item_type=="survey"
        items = @space.surveys
      elsif @item_type=="actuality"
        items = @space.actualities
      else
        items = Space.discoverables
      end

      if @q=="*"
        return items
      else
        return matches(@q, items)
      end
    end
  end

  def matches(q, items)
    return ( items.where("name like ?", "%#{q}%") + items.where("description like ?", "%#{q}%") + items.select { |e| !e.space? && !e.actuality? && e.type.id.to_s == q } ).uniq
  end
end
