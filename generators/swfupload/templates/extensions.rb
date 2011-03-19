class String
  def add_query!(hash)
    query_str = hash.to_query
    if self =~ /\?/
      self << "&"
      self << query_str
    else
      self << "?"
      self << query_str
    end
  end
end