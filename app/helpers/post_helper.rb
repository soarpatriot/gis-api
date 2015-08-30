module PostHelper

  def post_page(posts,before)
    if before
      posts = posts.where("posts.id < ?", before)
      sum = posts.count
      start = sum - Settings.paginate_per_page
      has_more = start > 0
      if start > 0
        posts = posts.limit "#{start}, #{Settings.paginate_per_page}"
      else
        posts = posts.limit Settings.paginate_per_page
      end
    else
      has_more = (posts.count - Settings.paginate_per_page) > 0
      posts = posts.limit(Settings.paginate_per_page)
    end

    present posts, with: PostEntity, current_user: current_user
    body( { has_more: has_more, data: body() })
  end

end
