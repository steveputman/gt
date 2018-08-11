context("test-fmt_percent.R")

test_that("formatting a column of numeric data as percentage values works correctly", {

  # Create an input data frame four columns: two
  # character-based and two that are numeric
  data_tbl <-
    data.frame(
      char_1 = c("saturday", "sunday", "monday", "tuesday",
                 "wednesday", "thursday", "friday"),
      char_2 = c("june", "july", "august", "september",
                 "october", "november", "december"),
      num_1 = c(1836.23, 2763.39, 937.29, 643.00, 212.232, 0, -23.24),
      num_2 = c(34, 74, 23, 93, 35, 76, 57),
      stringsAsFactors = FALSE)

  # Create a `gt_tbl` object with `gt()` and the
  # `data_tbl` dataset
  tab <- gt(data = data_tbl)

  # When attempting to format a column that does not exist
  # original table object is returned with no change to the
  # output data frame; extract `output_df` and determine that
  # no change is made
  expect_true(
    (tab %>%
       fmt_percent(columns = "num_3", decimals = 2) %>%
       render_formats("html"))[, 1:4] %>%
      lapply(is.na) %>% lapply(all) %>% unlist() %>% all())

  # Format the `num_1` column to 2 decimal places, use all
  # other defaults; extract `output_df` and compare to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2) %>%
       render_formats("html"))[["num_1"]],
    c("183,623.00%", "276,339.00%", "93,729.00%",
      "64,300.00%", "21,223.20%", "0.00%", "-2,324.00%"))

  # Format the `num_1` column to 5 decimal places, use all
  # other defaults; extract `output_df` and compare to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 5) %>%
       render_formats("html"))[["num_1"]],
    c("183,623.00000%", "276,339.00000%", "93,729.00000%",
      "64,300.00000%", "21,223.20000%", "0.00000%", "-2,324.00000%"))

  # Format the `num_1` column to 2 decimal places, drop the trailing
  # zeros, use all other defaults; extract `output_df` and compare to
  # expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2,
                   drop_trailing_zeros = TRUE) %>%
       render_formats("html"))[["num_1"]],
    c("183,623%", "276,339%", "93,729%", "64,300%",
      "21,223.2%", "0%", "-2,324%" ))

  # Format the `num_1` column to 2 decimal places, don't use digit
  # grouping separators, use all other defaults; extract `output_df`
  # and compare to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2, use_seps = FALSE) %>%
       render_formats("html"))[["num_1"]],
    c("183623.00%", "276339.00%", "93729.00%", "64300.00%",
      "21223.20%", "0.00%", "-2324.00%"))

  # Format the `num_1` column to 2 decimal places, use a single space
  # character as digit grouping separators, use all other defaults;
  # extract `output_df` and compare to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2, sep_mark = " ") %>%
       render_formats("html"))[["num_1"]],
    c("183 623.00%", "276 339.00%", "93 729.00%", "64 300.00%",
      "21 223.20%", "0.00%", "-2 324.00%"))

  # Format the `num_1` column to 2 decimal places, use a period for the
  # digit grouping separators and a comma for the decimal mark, use
  # all other defaults; extract `output_df` and compare to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2,
                   sep_mark = ".", dec_mark = ",") %>%
       render_formats("html"))[["num_1"]],
    c("183.623,00%", "276.339,00%", "93.729,00%", "64.300,00%",
      "21.223,20%", "0,00%", "-2.324,00%"))

  # Format the `num_1` column to 2 decimal places, apply parentheses to
  # all negative values, use all other defaults; extract `output_df` and
  # compare to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2, negative_val = "parens") %>%
       render_formats("html"))[["num_1"]],
    c("183,623.00%", "276,339.00%", "93,729.00%", "64,300.00%",
      "21,223.20%", "0.00%", "(2,324.00%)"))

  # Format the `num_1` column to 2 decimal places, prepend and append
  # all values by 2 different literals, use all other defaults; extract
  # `output_df` and compare to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2, pattern = "a {x}:n") %>%
       render_formats("html"))[["num_1"]],
    c("a 183,623.00%:n", "a 276,339.00%:n", "a 93,729.00%:n",
      "a 64,300.00%:n", "a 21,223.20%:n", "a 0.00%:n", "a -2,324.00%:n"))

  # Format the `num_1` column to 0 decimal places, place a space between
  # the percent sign (on the right) and the value, use all other defaults;
  # extract `output_df` and compare to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 0,
                   placement = "right", incl_space = TRUE) %>%
       render_formats("html"))[["num_1"]],
    c("183,623 %", "276,339 %", "93,729 %", "64,300 %",
      "21,223 %", "0 %", "-2,324 %"))

  # Format the `num_1` column to 0 decimal places, place a space between
  # the percent sign (on the left) and the value, use all other defaults;
  # extract `output_df` and compare to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 0,
                   placement = "left", incl_space = TRUE) %>%
       render_formats("html"))[["num_1"]],
    c("% 183,623", "% 276,339", "% 93,729", "% 64,300",
      "% 21,223", "% 0", "% -2,324"))

  # Format the `num_1` column to 2 decimal places, apply the `en_US`
  # locale and use all other defaults; extract `output_df` and compare
  # to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2, locale = "en_US") %>%
       render_formats("html"))[["num_1"]],
    c("183,623.00%", "276,339.00%", "93,729.00%",
      "64,300.00%", "21,223.20%", "0.00%", "-2,324.00%"))

  # Format the `num_1` column to 2 decimal places, apply the `da_DK`
  # locale and use all other defaults; extract `output_df` and compare
  # to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2, locale = "da_DK") %>%
       render_formats("html"))[["num_1"]],
    c("183.623,00%", "276.339,00%", "93.729,00%",
      "64.300,00%", "21.223,20%", "0,00%", "-2.324,00%"))

  # Format the `num_1` column to 2 decimal places, apply the `de_AT`
  # locale and use all other defaults; extract `output_df` and compare
  # to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2, locale = "de_AT") %>%
       render_formats("html"))[["num_1"]],
    c("183 623,00%", "276 339,00%", "93 729,00%",
      "64 300,00%", "21 223,20%", "0,00%", "-2 324,00%"))

  # Format the `num_1` column to 2 decimal places, apply the `et_EE`
  # locale and use all other defaults; extract `output_df` and compare
  # to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2, locale = "et_EE") %>%
       render_formats("html"))[["num_1"]],
    c("183 623,00%", "276 339,00%", "93 729,00%",
      "64 300,00%", "21 223,20%", "0,00%", "-2 324,00%"))

  # Format the `num_1` column to 2 decimal places, apply the `gl_ES`
  # locale and use all other defaults; extract `output_df` and compare
  # to expected values
  expect_equal(
    (tab %>%
       fmt_percent(columns = "num_1", decimals = 2, locale = "gl_ES") %>%
       render_formats("html"))[["num_1"]],
    c("183.623,00%", "276.339,00%", "93.729,00%",
      "64.300,00%", "21.223,20%", "0,00%", "-2.324,00%"))
})