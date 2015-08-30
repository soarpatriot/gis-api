module DiaryHelper

  def diary_page(diaries,before)
    if before
      diaries = diaries.where("diaries.id < ?", before)
      sum = diaries.count
      start = sum - Settings.paginate_per_page
      has_more = start > 0
      if start > 0
        diaries = diaries.limit "#{start}, #{Settings.paginate_per_page}"
      else
        diaries = diaries.limit Settings.paginate_per_page
      end
    else
      has_more = (diaries.count - Settings.paginate_per_page) > 0
      diaries = diaries.limit(Settings.paginate_per_page)
    end

    present diaries, with: DiaryEntity
    body( { has_more: has_more, data: body() })
  end

end
