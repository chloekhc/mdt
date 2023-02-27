info_page <- function(id) {
  psychTestR::one_button_page(psychTestR::i18n(id),
                              button_text = psychTestR::i18n("AMDI_0016_I_0001_1"))
}

info_image_page <- function(url) {
  psychTestR::one_button_page(div(p(img(src = url, width="100%")), p("")))
}

audio_ex_page <- function(prompt_id, url) {
  psychTestR::audio_NAFC_page(
    label = "ex",
    prompt = psychTestR::i18n(prompt_id),
    choices = psychTestR::i18n("AMDI_0016_I_0001_1"),
    url = url,
    save_answer = FALSE
  )
}

audio_ex_image_page <- function(image_url, url) {
  psychTestR::audio_NAFC_page(
    label = "ex",
    prompt = div(p(img(src = image_url, width="100%")), p("")),
    choices = psychTestR::i18n("AMDI_0016_I_0001_1"),
    show_controls = TRUE,
    url = url,
    save_answer = FALSE
  )
}

audio_ex_image_page1 <- function(image_url, url) {
  psychTestR::audio_NAFC_page(
    label = "ex",
    prompt = div(p(img(src = image_url, width="100%")), p("")),
    choices = psychTestR::i18n("AMDI_0016_I_0001_1"),
    url = url,
    show_controls = FALSE,
    save_answer = FALSE
  )
}

instructions <- function(media_dir, num_items) {
  c(
    psychTestR::code_block(function(state, ...) {
      psychTestR::set_local("do_intro", TRUE, state)
    }),
    psychTestR::while_loop(
      test = function(state, ...) psychTestR::get_local("do_intro", state),
      logic = c(
        info_image_page("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/1.jpg"),
        info_image_page("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/2.jpg"),
        info_image_page("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/3.jpg"),
        audio_ex_image_page("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/4.jpg", file.path(media_dir, "examples/ex1.mp3")),
        info_image_page("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/5.jpg"),
        info_image_page("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/6.jpg"),
        info_image_page("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/7.jpg"),
        info_image_page("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/8.jpg"),
        audio_ex_image_page1("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/9.jpg", file.path(media_dir, "examples/ex1.mp3")),
        info_image_page("https://raw.githubusercontent.com/chloekhc/mdt/master/fig/10.jpg"),
        practice(media_dir),
        ask_repeat()
      )),
    psychTestR::one_button_page(div(p(img(src = "https://raw.githubusercontent.com/chloekhc/mdt/master/fig/17.jpg", width="100%")), p("")))
  )
}

ask_repeat <- function() {
  psychTestR::NAFC_page(
    label = "ask_repeat",
    prompt = div(p(img(src = "https://raw.githubusercontent.com/chloekhc/mdt/master/fig/16.jpg", width="100%")), p("")),
    choices = c("go_back", "continue"),
    labels = lapply(c("AMDI_0008_R_0001_1", "AMDI_0008_R_0002_1"), psychTestR::i18n),
    save_answer = FALSE,
    arrange_vertically = TRUE,
    on_complete = function(state, answer, ...) {
      psychTestR::set_local("do_intro", identical(answer, "go_back"), state)
    }
  )
}
