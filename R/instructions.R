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
    show_controls = TRUE,
    save_answer = FALSE,
    autoplay = FALSE
  )
}

instructions <- function(media_dir, num_items) {
  c(
    psychTestR::code_block(function(state, ...) {
      psychTestR::set_local("do_intro", TRUE, state)
    }),
    info_image_page("https://decpsychloe.me/img/1.jpg"),
    info_image_page("https://decpsychloe.me/img/2.jpg"),
    info_image_page("https://decpsychloe.me/img/3.jpg"),
    audio_ex_image_page("https://decpsychloe.me/img/4.jpg", file.path(media_dir, "examples/ex1.mp3")),
    info_image_page("https://decpsychloe.me/img/6.jpg"),
    info_image_page("https://decpsychloe.me/img/8.jpg"),
    audio_ex_image_page1("https://decpsychloe.me/img/9.jpg", file.path(media_dir, "examples/ex1.mp3")),
    info_image_page("https://decpsychloe.me/img/10.jpg"),
    psychTestR::while_loop(
      test = function(state, ...) psychTestR::get_local("do_intro", state),
      logic = c(
        practice(media_dir),
        ask_repeat()
      )),
    psychTestR::one_button_page(div(p(img(src = "https://decpsychloe.me/img/17.jpg", width="100%")), p("")))
  )
}

ask_repeat <- function() {
  psychTestR::NAFC_page(
    label = "ask_repeat",
    prompt = div(p(img(src = "https://decpsychloe.me/img/16.jpg", width="100%")), p("")),
    choices = c("go_back", "continue"),
    labels = lapply(c("AMDI_0008_R_0001_1", "AMDI_0008_R_0002_1"), psychTestR::i18n),
    save_answer = FALSE,
    arrange_vertically = TRUE,
    on_complete = function(state, answer, ...) {
      psychTestR::set_local("do_intro", identical(answer, "go_back"), state)
    }
  )
}
