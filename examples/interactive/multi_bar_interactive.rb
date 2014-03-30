require 'plotrb'

data1 = pdata.name('data1').values(
    [
      {x: 1,  y: 28}, {x: 2,  y: 55},
      {x: 3,  y: 43}, {x: 4,  y: 91},
      {x: 5,  y: 81}, {x: 6,  y: 53},
      {x: 7,  y: 19}, {x: 8,  y: 87},
      {x: 9,  y: 52}, {x: 10, y: 48},
      {x: 11, y: 24}, {x: 12, y: 49},
      {x: 13, y: 87}, {x: 14, y: 66},
      {x: 15, y: 17}, {x: 16, y: 27},
      {x: 17, y: 68}, {x: 18, y: 16},
      {x: 19, y: 49}, {x: 20, y: 15}
    ]
)

data2 = pdata.name('data2').values(
    [
      {x: 1,  y: 8}, {x: 2,  y: 25},
      {x: 3,  y: 4}, {x: 4,  y: 71},
      {x: 5,  y: 21}, {x: 6,  y: 51},
      {x: 7,  y: 13}, {x: 8,  y: 77},
      {x: 9,  y: 52}, {x: 10, y: 42},
      {x: 11, y: 14}, {x: 12, y: 29},
      {x: 13, y: 82}, {x: 14, y: 56},
      {x: 15, y: 1}, {x: 16, y: 22},
      {x: 17, y: 8}, {x: 18, y: 36},
      {x: 19, y: 48}, {x: 20, y: 12}
    ]
)

mark = rect_mark.from(data1) do
  enter do
  end
  update do
    fill 'steelblue'
  end
  hover do
    fill 'red'
  end
end

vis = visualization.width(400).height(200) do
  padding top: 10, left: 30, bottom: 30, right: 10
  data data1, data2
  marks mark
  enable :interactive
end

vis.output_server("multi_bar_interactive")
