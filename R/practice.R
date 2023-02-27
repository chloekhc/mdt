practice <- function(media_dir) {
  unlist(lapply(
    list(list(id = "ex2", answer = "3"),
         list(id = "ex3", answer = "1")
    ),
    function(x) {
      list(
        psychTestR::audio_NAFC_page(
          label = "practice_question",
          prompt = div(p(img(src = "https://raw.githubusercontent.com/chloekhc/mdt/master/fig/11.jpg", width="100%")), p("")),
          url = file.path(media_dir, "examples", paste0(x$id, ".mp3")),
          choices = c("1", "2", "3"),
          arrange_choices_vertically = FALSE,
          save_answer = FALSE
        ),
        psychTestR::reactive_page(function(answer, ...) {
          psychTestR::one_button_page(
              if (answer == x$answer){ img(src = "https://raw.githubusercontent.com/chloekhc/mdt/master/fig/12.jpg", width="100%") } else
                 if (answer != x$answer){
                   if (x$answer == "3") {img(src = "https://raw.githubusercontent.com/chloekhc/mdt/master/fig/15.jpg", width="100%")} else
                     {img(src = "https://raw.githubusercontent.com/chloekhc/mdt/master/fig/13.jpg", width="100%")}
                 }, button_text = psychTestR::i18n("AMDI_0016_I_0001_1"))}
      ))}
    ))}
