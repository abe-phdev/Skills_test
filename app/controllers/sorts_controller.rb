class SortsController < ApplicationController
  BUBBLE_SORT = 'Bubble Sort'

  def index
    @sorts = Sort.all
  end

  def new
    @sort = Sort.new
  end

  def create
    @sort = Sort.new(sort_params)
    check_sorting_method

    if @sort.save
      redirect_to sorts_path
    else
      render :new
    end
  end

  private
    def sort_params
      params.require(:sort).permit(:word, :sorting_method)
    end

    def check_sorting_method
      return bubble_sort if @sort.sorting_method == BUBBLE_SORT
      quick_sort 
    end

    def bubble_sort
      array_string = @sort.word.split('')
      word_length = @sort.word.size

      loop do
        swapped = false

        (word_length - 1).times do |idx|
          if array_string[idx] > array_string[idx+1]
            array_string[idx], array_string[idx+1] = array_string[idx+1], array_string[idx]
            swapped = true
          end
        end
        break if not swapped
      end
      @sort.word = array_string.join('')
    end
end
