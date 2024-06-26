#' Standalone MDT
#'
#' This function launches a standalone testing session for the MDT.
#' This can be used for data collection, either in the laboratory or online.
#' @param title (Scalar character) Title to display during testing.
#' @param admin_password (Scalar character) Password for accessing the admin panel.
#' @param researcher_email (Scalar character)
#' If not \code{NULL}, this researcher's email address is displayed
#' at the bottom of the screen so that online participants can ask for help.
#' @param languages (Character vector)
#' Determines the languages available to participants.
#' The first language is selected by default.
#' Defaults to the value returned by \code{\link{mdt_languages}()}.
#' @param dict The psychTestR dictionary used for internationalisation.
#' @param ... Further arguments to be passed to \code{\link{mdt}()}.
#' @export
standalone_mdt <- function(title = "Melody discrimination test",
                           admin_password = "replace-with-secure-password",
                           researcher_email = NULL,
                           languages = mdt_languages(),
                           dict = mdt::mdt_dict,
                           ...) {
  elts <- c(
    mdt::mdt(dict = dict, ...),
    # psychTestR::elt_save_results_to_disk(complete = TRUE),
    psychTestR::new_timeline(
      psychTestR::final_page(
        div(p(img(src = "https://raw.githubusercontent.com/chloekhc/mdt/master/fig/19.jpg", width="100%")), p(tags$a(href="http://decpsychloe.me/cabat/", "Next Step")))
      ), dict = dict)
  )

  psychTestR::make_test(
    elts,
    opt = psychTestR::pt_options(title = title,
                                 admin_password = admin_password,
                                 researcher_email = researcher_email,
                                 demo = FALSE,
                                 languages = languages))
}
