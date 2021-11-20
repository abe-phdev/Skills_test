class SortsController < ApplicationController
  BUBBLE_SORT = 'Bubble Sort'
  FIRST = 0

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
      return bubble_sort(array_string, word_length) if @sort.sorting_method == BUBBLE_SORT
      quick_sort(array_string, FIRST, word_length - 1)
    end

    def array_string
      @sort.word.split('')
    end

    def word_length
      @sort.word.size
    end

    def bubble_sort(array, size)
      loop do
        swapped = false

        (size - 1).times do |idx|
          if array[idx] > array[idx+1]
            array[idx], array[idx+1] = array[idx+1], array[idx]
            swapped = true
          end
        end
        break if not swapped
      end
      @sort.word = array.join('')
    end

    def quick_sort(array, first, last)
      if first < last
        j = partition(array, first, last)
        quick_sort(array, first, j-1)
        quick_sort(array, j+1, last)
      end
      @sort.word = array.join('')
    end

    def partition(array, first, last)
      pivot = array[last]
      pIndex = first
      i = first

      while i < last
        if array[i] <= pivot
          array[i], array[pIndex] = array[pIndex], array[i]
          pIndex += 1
        end
        i += 1
      end

      array[pIndex], array[last] = array[last], array[pIndex]
      return pIndex
    end
end
