module ApplicationHelper
  def course_gradient_colors(course)
    # Define a set of gradients for courses
    gradients = [
      '#4158D0, #C850C0',
      '#43C6AC, #191654',
      '#8E2DE2, #4A00E0',
      '#4776E6, #8E54E9'
    ]
    
    # Use the course id to consistently pick a gradient
    gradient_index = course.id.to_i % gradients.length
    gradients[gradient_index]
  end
end
