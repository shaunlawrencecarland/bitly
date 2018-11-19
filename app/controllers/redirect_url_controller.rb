class RedirectUrlController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    msg = "URL with slug: '#{slug}' was not found"
    render json: { error: msg }, status: 404
  end

  def index
    # TODO: Increment count on redirect!
    unless Url.valid_slug?(slug)
      msg = "Slug not valid.  Slug must contain only alphanumeric characters"
      return render json: {error: msg}, status: :unprocessable_entity
    end

    url_id = UrlHelper.decode(slug)
    url = Url.find(url_id)

    redirect_to url.path, status: 301
  end

  private
  def slug
    params.require(:slug)
  end
end
