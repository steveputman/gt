library(gt)

# Create a display table based on `iris` Edgar Anderson's Iris Data

iris_tbl <-
  gt(data = iris) %>%
  cols_split_delim(delim = ".") %>%
  cols_move_to_start(columns = vars(Species)) %>%
  fmt_number(
    columns = vars(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width),
    decimals = 1) %>%
  tab_heading(
    title = md("The **iris** dataset"),
    headnote = md("[All about *Iris setosa*, *versicolor*, and *virginica*]")) %>%
  tab_source_note(
    source_note = md("The data were collected by *Anderson* (1935)."))

iris_tbl