rescue_from NotAuthorizedError, with: :render_404
  
def render_404(exception = nil)
  if exception
    logger.info "Rendering 404 with exception: #{exception.message}"
  end
   
  render file: "#{Rails.root}/public/404.html", status: 404, content_type: 'text/html'
end
